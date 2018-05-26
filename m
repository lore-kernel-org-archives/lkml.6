Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030990AbeEZAan (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 20:30:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43752 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030839AbeEZAam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 20:30:42 -0400
Date: Sat, 26 May 2018 01:30:26 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Liu, Changcheng" <changcheng.liu@intel.com>
Cc: jiangshanlai@gmail.com, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: define struct workqueue_struct in C file
Message-ID: <20180526003026.GM30522@ZenIV.linux.org.uk>
References: <20180524151013.GA175207@sofia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524151013.GA175207@sofia>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 11:10:14PM +0800, Liu, Changcheng wrote:
> Hi all,
> 	I have one confusion about workqueue_struct:
> 	1) Why struct workqueue_struct is defined in C file instead of
> 	header file?

To prevent all other code poking in its guts?

> 	   I'm trying to print "workqueue_struct:name" field in one external
> 	   build module. "workqueue_struct:name" can't be accessed directly.

... thus allowing implementation details be changed at later point without
worrying about breaking other code.

There are objects that are accessible via opaque pointers, with the set of
(widely used) primitives being the only code that has access to actual
structure layout.  Some are in a local header (outside of include search
path, and very much *NOT* supposed to be included outside of a few C
files implementing the public interfaces), some are outright local in
C file.

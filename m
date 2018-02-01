Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeBAQDv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:03:51 -0500
Received: from ms.lwn.net ([45.79.88.28]:41654 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751582AbeBAQDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:03:49 -0500
Date: Thu, 1 Feb 2018 09:03:48 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: "Brown, Nicholas" <nb930b@intl.att.com>
Cc: "joe@perches.com" <joe@perches.com>,
        "apw@canonical.com" <apw@canonical.com>, "me@tobin.cc" <me@tobin.cc>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: warn if changed lines exceeds a maximum
 size
Message-ID: <20180201090348.61c9be3f@lwn.net>
In-Reply-To: <1517499752.3668.10.camel@intl.att.com>
References: <1517343904.3063.33.camel@intl.att.com>
        <20180130202655.22990-1-nick.brown@att.com>
        <1517481518.3063.92.camel@intl.att.com>
        <1517489679.7489.31.camel@perches.com>
        <1517499752.3668.10.camel@intl.att.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2018 15:42:35 +0000
"Brown, Nicholas" <nb930b@intl.att.com> wrote:

> > I think the metric is too simplistic and
> > not particularly useful.  
> 
> I'm not sure it's any more simplistic than than the character line
> length limit, which is there to prompt thought on code nesting levels,
> etc. And as it has to be explicitly configured it allows developers the
> discretion to determine a code change size that meaningful in a given
> situation.

The line-length limit relates directly to code readability and
non-infringement of a developer's sacred right to work unimpeded on an
80x24 xterm (the last vt100 died, unfortunately).

A line-count limit lacks even that justification.  The rule on splitting
patches is entirely about logical changes that can be reviewed
independently.  Some of those changes involve a lot of lines, others do
not.  If the correct splits do not come to you when you're writing the
changelogs for your patches (or before), a tool nagging about line counts
really isn't going to help.  I would expect it to miss most patches
actually in need of splitting while complaining about many patches that
are just fine.

Thanks for working to improve the tools - they certainly can afford a lot
of improvement!  But my own suggestion would be to look a bit further for
improvements that will be truly helpful to the development community.

Thanks,

jon

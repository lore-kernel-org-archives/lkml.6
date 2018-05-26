Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032220AbeEZRMJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 13:12:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56798 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031950AbeEZRMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 13:12:07 -0400
Date: Sat, 26 May 2018 18:12:06 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Lei Chen <losemyheaven@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Why does d_splice_alias need to check IS_ROOT?
Message-ID: <20180526171206.GP30522@ZenIV.linux.org.uk>
References: <CAKEZqKJhZNoF-29ymEmAjiYfVn64q5mHrMY9sC2NZ=EDqTHjeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEZqKJhZNoF-29ymEmAjiYfVn64q5mHrMY9sC2NZ=EDqTHjeA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2018 at 12:33:40AM +0800, Lei Chen wrote:
> Hello list,
> 
> I'm insteresting in how hard link and denry lookup work and their
> implementation.
> 
> I know that this interface tries to connect an inode to a dentry, but
> why does it need
> to check whether the inode alias IS_ROOT if the inode represents a directory?
> And the code process in different way according to check result.  What
> occasions
> are they used for?

If it's disconnected (and not an ancestor of the place where we want it),
we can just move it in place, no questions asked.  If it is *NOT*
disconnected, the only thing we can do is to detach it from where it
is and move it over.  Which takes a lot more care wrt locking.

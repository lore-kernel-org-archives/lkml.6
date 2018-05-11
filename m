Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbeEKXCp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 19:02:45 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43452 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeEKXCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 19:02:43 -0400
X-Google-Smtp-Source: AB8JxZrQ1d67g751GjHntGJPkM4Oqq4k1nlrCtyb3W4xbt07x0hVvxjUE1evQO8BFHVoEGOkMgc4qg==
Date: Sat, 12 May 2018 02:01:20 +0300
From: Nick Simonov <nicksimonovv@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: rydberg@bitmath.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: fix coding style issues in input.c
Message-ID: <20180511230120.GA23354@gmail.com>
References: <1525874834-20432-1-git-send-email-nicksimonovv@gmail.com>
 <20180510003313.GD91762@dtor-ws>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20180510003313.GD91762@dtor-ws>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

 Wed, May 09, 2018 at 05:33:13PM -0700, Dmitry Torokhov wrote:
> Hi NIck,
> 
> On Wed, May 09, 2018 at 05:07:14PM +0300, Nick Simonov wrote:
> > This is a patch to the input.c file that fixes
> > up warning found by checkpatch.pl tool
> > 
> > Signed-off-by: Nick Simonov <nicksimonovv@gmail.com>
> > ---
> >  drivers/input/input.c | 52 ++++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 33 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/input/input.c b/drivers/input/input.c
> > index 9785546..e18fdae 100644
> > --- a/drivers/input/input.c
> > +++ b/drivers/input/input.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * The input core
> >   *
> > @@ -252,7 +253,8 @@ static int input_handle_abs_event(struct input_dev *dev,
> >  	}
> >  
> >  	/* Flush pending "slot" event */
> > -	if (is_mt_event && mt && mt->slot != input_abs_get_val(dev, ABS_MT_SLOT)) {
> > +	if (is_mt_event && mt && mt->slot !=
> > +		input_abs_get_val(dev, ABS_MT_SLOT)) {
> >  		input_abs_set_val(dev, ABS_MT_SLOT, mt->slot);
> 
> So now it is not immediately clear what is part of condition and what is
> part of body.
> 
> I am sorry to say, but with most of these changes the cure is worse than
> the disease. If you were fixing the code and adjusted the affected lines
> so they are under 80 columns limit that would be one thing, but just
> reformatting for the sake of it is not really helpful.
> 
> Thanks.
> 
> -- 
> Dmitry

Dmitry thanks for your comment. I deleted all my changes except one
and prepare a new patch for it. 

In function input_set_capability when it go through default statment 
it is use hard coded function name "input_set_capability" in pr_err() call.
I replace it using "%s" __func__ instead.

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="0001-input-replace-hard-coded-string-with-__func__-in-pr_.patch"

>From 2aef27ca4896b8d9e64fd1417965793acfba3653 Mon Sep 17 00:00:00 2001
From: Nick Simonov <nicksimonovv@gmail.com>
Date: Sat, 12 May 2018 01:24:47 +0300
Subject: [PATCH] input: replace hard coded string with __func__ in pr_err()

Change hardcoded string "input_set_capability"
in pr_err() function call, replace it with
"%s" __func__ instead.

Signed-off-by: Nick Simonov <nicksimonovv@gmail.com>
---
 drivers/input/input.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 9785546..6365c19 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1943,8 +1943,7 @@ void input_set_capability(struct input_dev *dev, unsigned int type, unsigned int
 		break;
 
 	default:
-		pr_err("input_set_capability: unknown type %u (code %u)\n",
-		       type, code);
+		pr_err("%s: unknown type %u (code %u)\n", __func__, type, code);
 		dump_stack();
 		return;
 	}
-- 
2.7.4


--vtzGhvizbBRQ85DL--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbeFEGK5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:10:57 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41919 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751603AbeFEGKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:10:55 -0400
X-Google-Smtp-Source: ADUXVKK6E9a9LIGSa+V3gCqWhmfYyMcySsi0q/h2jn4dO++5r4hWNTd/E7xxJCHPxULy1MnRSEQkXw==
Date: Tue, 5 Jun 2018 08:10:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>,
        Janani Sankara Babu <jananis37@gmail.com>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
Subject: Re: [greybus-dev] [PATCH] Staging:greybus Fix comparison to NULL
Message-ID: <20180605061038.GF13775@localhost>
References: <1528030371-3822-1-git-send-email-jananis37@gmail.com>
 <20180605053236.u57riboa47so66rr@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605053236.u57riboa47so66rr@vireshk-i7>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 11:02:36AM +0530, Viresh Kumar wrote:
> On 03-06-18, 08:52, Janani Sankara Babu wrote:
> > This patch replaces comparison of var to NULL with !var
> > 
> > Signed-off-by: Janani Sankara Babu <jananis37@gmail.com>
> > ---
> >  drivers/staging/greybus/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/greybus/core.c b/drivers/staging/greybus/core.c
> > index dafa430..5d14a4e 100644
> > --- a/drivers/staging/greybus/core.c
> > +++ b/drivers/staging/greybus/core.c
> > @@ -48,7 +48,7 @@ static bool greybus_match_one_id(struct gb_bundle *bundle,
> >  static const struct greybus_bundle_id *
> >  greybus_match_id(struct gb_bundle *bundle, const struct greybus_bundle_id *id)
> >  {
> > -	if (id == NULL)
> > +	if (!id)
> 
> It is pretty much personal preference and there is no good reason to
> accept this patch really.

I agree with you, Viresh, but greybus is still living in staging which
makes checkpatch enable the --strict option, thereby forcing its authors
preferences onto the rest of us.

I also do understand Greg's point that while --strict is enabled,
rejecting such patches will probably cause some new submitters to do
work for nothing, which is not good.

On the other hand, I at least think we should enforce having a patch
description that clearly indicates that this is just something to make
checkpatch happy (reserving the term "fix" for proper fixes, at least if
not used in conjunction with "checkpatch warning").

So Janani, would you mind resubmitting this patch with a slightly
modified commit message, such as:

	staging: greybus: clean up NULL comparisons

	Replace comparison of var to NULL with !var in order to address
	a checkpatch (strict) warning.

You could also change the sole remaining comparison to NULL in bundle.c
in the same patch.

Thanks,
Johan

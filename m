Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeEGHUS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 03:20:18 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40717 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeEGHUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 03:20:15 -0400
X-Google-Smtp-Source: AB8JxZpR+IBH7qmljMxJ99xbCDZxucAlVe81flHcK+8+zcsdSmOUlWFPSEqETsrwoilBdxOcK3utGQ==
Date: Mon, 7 May 2018 09:20:11 +0200
From: Johan Hovold <johan@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nathan Chancellor <natechancellor@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [greybus-dev] [PATCH] staging: greybus: Remove unused local
 variable
Message-ID: <20180507072011.GL2285@localhost>
References: <20180506065044.25311-1-natechancellor@gmail.com>
 <20180507050546.qiuigbsohhallell@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180507050546.qiuigbsohhallell@vireshk-i7>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 10:35:46AM +0530, Viresh Kumar wrote:
> On 05-05-18, 23:50, Nathan Chancellor wrote:
> > Fixes the following W=1 warning: variable ‘intf_id’ set but
> > not used [-Wunused-but-set-variable]
> > 
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/staging/greybus/svc.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/svc.c b/drivers/staging/greybus/svc.c
> > index a874fed761a1..a2bb7e1a3db3 100644
> > --- a/drivers/staging/greybus/svc.c
> > +++ b/drivers/staging/greybus/svc.c
> > @@ -1137,7 +1137,6 @@ static int gb_svc_intf_reset_recv(struct gb_operation *op)
> >  	struct gb_svc *svc = gb_connection_get_data(op->connection);
> >  	struct gb_message *request = op->request;
> >  	struct gb_svc_intf_reset_request *reset;
> > -	u8 intf_id;
> >  
> >  	if (request->payload_size < sizeof(*reset)) {
> >  		dev_warn(&svc->dev, "short reset request received (%zu < %zu)\n",
> > @@ -1146,8 +1145,6 @@ static int gb_svc_intf_reset_recv(struct gb_operation *op)
> >  	}
> >  	reset = request->payload;
> >  
> > -	intf_id = reset->intf_id;
> > -
> >  	/* FIXME Reset the interface here */
> >  
> >  	return 0;
> 
> Don't you get a new error after removing this, i.e "reset set but unused" ? Or
> the sizeof() operation on that suppresses those warnings ..

That was my initial reaction as well, but I failed to notice the sizeof
which prevents the new warning.

> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Johan Hovold <johan@kernel.org>

Thanks,
Johan

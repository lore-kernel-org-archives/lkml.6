Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF44C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5273920843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5273920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mev.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeICTRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:17:18 -0400
Received: from smtp73.iad3a.emailsrvr.com ([173.203.187.73]:42757 "EHLO
        smtp73.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725949AbeICTRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:17:18 -0400
X-Greylist: delayed 531 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Sep 2018 15:17:17 EDT
Received: from smtp34.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp34.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id D8C0C24CDB;
        Mon,  3 Sep 2018 10:47:56 -0400 (EDT)
X-Auth-ID: siepeng@mev.co.uk
Received: by smtp34.relay.iad3a.emailsrvr.com (Authenticated sender: siepeng-AT-mev.co.uk) with ESMTPSA id 54EBA24CBB;
        Mon,  3 Sep 2018 10:47:56 -0400 (EDT)
X-Sender-Id: siepeng@mev.co.uk
Received: from [10.0.0.185] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 03 Sep 2018 10:47:56 -0400
Subject: Re: [PATCH 1/4] staging: comedi: Correct multiline dereference as per
 TODO
To:     Ray Clinton <mr.ray.clinton@gmail.com>, greg@kroah.com
Cc:     hsweeten@visionengravers.com, linux-kernel@vger.kernel.org
References: <CAPMnawvndQUGj4ohrTCPrwcvZdS-3FrHGsNeN4N7OJ_YGK-QfQ@mail.gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <a7eeb3a5-ba6a-14c4-8ed4-7aa29d3840ce@mev.co.uk>
Date:   Mon, 3 Sep 2018 15:47:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPMnawvndQUGj4ohrTCPrwcvZdS-3FrHGsNeN4N7OJ_YGK-QfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/18 18:32, Ray Clinton wrote:
> Using checkpatch.pl I was able to find a multiline dereference which goes
> again the coding style for the kernel. I'm still working on my email client so
> the indentation looks bad here (in gmail) but the arguments for
> comedi_check_trigger_arg_min should go just under the opening (

The patch description should describe what the patch does, not how bad 
the indentation loos in your email client.

> Signed-off-by: Ray Clinton <mr.ray.clinton@gmail.com>
> ---
>   drivers/staging/comedi/drivers/dt3000.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/dt3000.c
> b/drivers/staging/comedi/drivers/dt3000.c
> index 2edf3ee..6bc5c86 100644
> --- a/drivers/staging/comedi/drivers/dt3000.c
> +++ b/drivers/staging/comedi/drivers/dt3000.c
> @@ -439,9 +439,9 @@ static int dt3k_ai_cmdtest(struct comedi_device *dev,
> 
>                  if (cmd->scan_begin_src == TRIG_TIMER) {
>                          arg = cmd->convert_arg * cmd->scan_end_arg;
> -                       err |= comedi_check_trigger_arg_min(&cmd->
> -                                                           scan_begin_arg,
> -                                                           arg);
> +                       err |= comedi_check_trigger_arg_min(
> +                                                          &cmd->scan_begin_arg,
> +                                                          arg);
>                  }
>          }
> 
> --
> 2.7.4
> 

I can't get the patch to apply.  Something is converting tabs to spaces, 
and I assume it is your email client doing that.  I recommend using the 
git send-email command to send the patches, after configuring your git 
to send emails via Gmail.  You can google how to do that, but here is a 
starting point: https://gist.github.com/jasonkarns/4354421

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-

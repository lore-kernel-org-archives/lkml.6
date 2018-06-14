Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6DDACC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E31C208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E31C208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mev.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755035AbeFNLI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:08:57 -0400
Received: from smtp97.iad3b.emailsrvr.com ([146.20.161.97]:41474 "EHLO
        smtp97.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754790AbeFNLI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:08:56 -0400
X-Greylist: delayed 4212 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jun 2018 07:08:55 EDT
Received: from smtp5.relay.iad3b.emailsrvr.com (localhost [127.0.0.1])
        by smtp5.relay.iad3b.emailsrvr.com (SMTP Server) with ESMTP id 57C534006E;
        Thu, 14 Jun 2018 07:08:55 -0400 (EDT)
X-Auth-ID: siepeng@mev.co.uk
Received: by smtp5.relay.iad3b.emailsrvr.com (Authenticated sender: siepeng-AT-mev.co.uk) with ESMTPSA id 7E19E4006B;
        Thu, 14 Jun 2018 07:08:54 -0400 (EDT)
X-Sender-Id: siepeng@mev.co.uk
Received: from [10.0.0.185] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 14 Jun 2018 07:08:55 -0400
Subject: Re: [PATCH v4] staging: comedi: Improved readability of function
 comedi_nsamples_left.
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Chris Opperman <eklikeroomys@gmail.com>
Cc:     devel@driverdev.osuosl.org, Frank Mori Hess <fmh6jj@gmail.com>,
        Simo Koskinen <koskisoft@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <1528837793-11765-1-git-send-email-eklikeroomys@gmail.com>
 <20180613092955.vc5impf46prhcur7@mwanda> <20180613182643.GA14100@kerdev>
 <20180613190549.ugl43yee4f3thk4t@mwanda>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <48e9826d-3f60-a79a-779a-2296a89afad0@mev.co.uk>
Date:   Thu, 14 Jun 2018 12:08:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180613190549.ugl43yee4f3thk4t@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/18 20:05, Dan Carpenter wrote:
> On Wed, Jun 13, 2018 at 08:26:43PM +0200, Chris Opperman wrote:
>> Hi Dan/Ian,
>>
>> Noted your comments regarding additional text, thanks! Just curious whether
>> the "scissors" format given at the link below is valid?
>>
>> https://kernelnewbies.org/PatchTipsAndTricks
>>
>> It is given as an alternative to placing additional text below the
>> cut-off line.
>>
> 
> Try it yourself.  Save your email as email.txt and then
> `cat email.txt | git am` and then review the patch with git log -p.
> 
> I've seen people do the scissors thing, but I assume the maintainer has
> to hand edit the log which we refuse to do.

It can be done automatically with the git am -c or --scissors option, or 
by setting mailinfo.scissors to true in the git config.  But since the 
use of these special scissors lines is not documented in 
Documentation/process/submitting-patches.rst, I don't think it is safe 
to assume that no manual intervention would be required by the 
maintainer to deal with it.

I wonder where the "scissors" advice on the kernelnewbies page came from?

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-

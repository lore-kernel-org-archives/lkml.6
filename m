Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Gw8iHHc+HluRUQAAmS7hNA
	; Mon, 11 Jun 2018 09:19:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0FEEC608CE; Mon, 11 Jun 2018 09:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528708794;
	bh=ISC6nJctSaMi6Ldvcu9Y2rRFdtEVaHb/kP0RWYrJYgo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=I0UAUVjpZEJKEIDQLB/YCs8aIOUO4Rk23lUhMmgD5Nqw+DoqRNC8IWs6G8MVet1/k
	 Xu2i0yOitocKUfGLZVub0Rc4o5pm7Zv4FMv5iFK7P+mWLjiXCo/fZEQGP7FrPzKMuP
	 iMRcGYczVzqh0BTLMZTUD1WWZs7oOzUjNRwL7LWk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6A63560792;
	Mon, 11 Jun 2018 09:19:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gSqXH7Nn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OOeiY7F4"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A63560792
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbeFKJTt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:19:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41914 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754010AbeFKJTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:19:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 801B96089E; Mon, 11 Jun 2018 09:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528708787;
        bh=ISC6nJctSaMi6Ldvcu9Y2rRFdtEVaHb/kP0RWYrJYgo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gSqXH7NnDgAfGbg5055j97zMWPCiEoerT0qFEO65YdzBPEngj2dPdXFF8HS4KUBRU
         sILVGnEZfL8Ck+RF2OscTNkV1OlXtJbo+Zw169rVKUmFvfUAf0scI6vw5KfPU6i6VR
         KGlN0iqSFXsJXJHb447EiguikKArJcRbEIJzBXA4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 54B7F60791;
        Mon, 11 Jun 2018 09:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528708786;
        bh=ISC6nJctSaMi6Ldvcu9Y2rRFdtEVaHb/kP0RWYrJYgo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OOeiY7F4MPHn1cHY/uZz/Z5J9x5FPOI11JA5LnW3RNRFijI3I0PN8ncd/lr4ZshVk
         Kqgrn5LqLiZzUwkjh/Bi0jq1yx/NGS5VXu72G75wfGdkdcV2pT2o+uSJRziWEnJ5e/
         mHzLseIm7ChwcyuEqLHq/xn1KQgUtSS62XDXAotg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Jun 2018 14:49:46 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH v3 15/16] mtd: rawnand: qcom: helper function for raw read
In-Reply-To: <20180607144350.1a4427a0@xps13>
References: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
 <1527250904-21988-16-git-send-email-absahu@codeaurora.org>
 <20180527155311.4c05d7ab@xps13>
 <19569fdc057754978298a7e7afc9016a@codeaurora.org>
 <20180607144350.1a4427a0@xps13>
Message-ID: <ad00e3739457dadc919bbebf9f6901b7@codeaurora.org>
X-Sender: absahu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-07 18:13, Miquel Raynal wrote:
> Hi Abhishek,
> 
> On Mon, 28 May 2018 13:04:45 +0530, Abhishek Sahu
> <absahu@codeaurora.org> wrote:
> 
>> On 2018-05-27 19:23, Miquel Raynal wrote:
>> > Hi Abhishek,
>> > > On Fri, 25 May 2018 17:51:43 +0530, Abhishek Sahu
>> > <absahu@codeaurora.org> wrote:
>> > >> This patch does minor code reorganization for raw reads.
>> >> Currently the raw read is required for complete page but for
>> >> subsequent patches related with erased codeword bit flips
>> >> detection, only few CW should be read. So, this patch adds
>> >> helper function and introduces the read CW bitmask which
>> >> specifies which CW reads are required in complete page.
>> >> >> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
>> >> ---

  <snip>

>> >> +	for (i = start_step; i < last_step; i++) {
>> > > This comment applies for both patches 15 and 16:
>> > > I would really prefer having a qcom_nandc_read_cw_raw() that reads only
>> > one CW. From qcom_nandc_read_page_raw() you would loop over all the CW
>> > calling qcom_nandc_read_cw_raw() helper (it's raw reads, we don't care
>> > about performances)
>> 
>>   Doing that way will degrade performances hugely.
>> 
>>   Currently once we formed the descriptor, the DMA will take care
>>   of complete page data transfer from NAND device to buffer and will
>>   generate single interrupt.
>> 
>>   Now it will form one CW descriptor and wait for it to be finished.
>>   In background, the data transfer from NAND device will be also
>>   split and for every CW, it will give the PAGE_READ command again,
>>   which is again time consuming.
>> 
>>   Data transfer degradation is ok but it will increase CPU time
>>   and number of interrupts which will impact other peripherals
>>   performance that time.
>> 
>>   Most of the NAND parts has 4K page size i.e 8 CWs.
>> 
>> > and from ->read_page_raw() you would check
>> > CW with uncorrectable errors for being blank with that helper. You
>> > would avoid the not-so-nice logic where you read all the CW between the
>> > first bad one and the last bad one.
>> >
>>   The reading b/w first CW and last CW is only from NAND device to 
>> NAND
>>   HW buffers. The NAND controller has 2 HW buffers which is used to
>>   optimize the traffic throughput between the NAND device and
>>   system memory,in both directions. Each buffer is 544B in size: 512B
>>   for data + 32B spare bytes. Throughput optimization is achieved by
>>   executing internal data transfers (i.e. between NANDc buffers and
>>   system memory) simultaneously with NAND device operations.
>> 
>>   Making separate function won't help in improving performance for
>>   this case either since once every thing is set for reading page
>>   (descriptor formation, issue the PAGE_READ, Data transfer from
>>   Flash array to data register in NAND device), the read time from
>>   device to NAND HW buffer is very less. Again, we did optimization
>>   in which the copying from NAND HW buffer to actual buffer is being
>>   done only for those CW's only.
>> 
>>   Again, in this case CPU time will be more.
>> 
> 
> 
> I understand the point and thanks for detailing it. But raw access
> happen either during debug (we don't care about CPU time) or when there
> is an uncorrectable error, which is very unlikely to happen very often
> when using eg. UBI/UBIFS. So I'm still convinced it is better to have a
> _simple_ and straightforward code for this path than something way
> harder to understand and much faster.
> 
> You can add a comment to explain what would be the fastest way and
> why though.
> 

  Thanks Miquel. I will do the changes to make function for
  single codeword raw read.

  Regards,
  Abhishek

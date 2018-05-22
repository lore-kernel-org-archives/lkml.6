Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeEVOQB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:16:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48744 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbeEVOP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:15:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Tue, 22 May 2018 19:45:57 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH v2 10/14] mtd: rawnand: qcom: fix return value for raw
 page read
In-Reply-To: <20180522140416.252fb398@xps13>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
 <1525350041-22995-11-git-send-email-absahu@codeaurora.org>
 <20180522140416.252fb398@xps13>
Message-ID: <75ef7936bd1da87f54cac867103a83d6@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-22 17:34, Miquel Raynal wrote:
> Hi Abhishek,
> 
> On Thu,  3 May 2018 17:50:37 +0530, Abhishek Sahu
> <absahu@codeaurora.org> wrote:
> 
>> Currently zero is being returned for all raw page read so
>> fix the same.
> 
> What about "Fix value returned by ->read_page_raw() to be the
> actual operation status, instead of always 0."?
> 

  Sure Miquel. It looks better.
  I will change this.

  Thanks,
  Abhishek

>> 
>> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
>> ---
>> * Changes from v1:
>> 
>>  NEW CHANGE
>> 
>>  drivers/mtd/nand/raw/qcom_nandc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c 
>> b/drivers/mtd/nand/raw/qcom_nandc.c
>> index f85d8ab..17b7f3af 100644
>> --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> @@ -1900,7 +1900,7 @@ static int qcom_nandc_read_page_raw(struct 
>> mtd_info *mtd,
>> 
>>  	free_descs(nandc);
>> 
>> -	return 0;
>> +	return ret;
>>  }
>> 
>>  /* implements ecc->read_oob() */
> 
> Thanks,
> Miquèl

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751592AbeEVOLQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:11:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45360 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbeEVOLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:11:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Tue, 22 May 2018 19:41:09 +0530
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
Subject: Re: [PATCH v2 07/14] mtd: rawnand: qcom: fix null pointer access for
 erased page detection
In-Reply-To: <20180522091647.74884137@xps13>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
 <1525350041-22995-8-git-send-email-absahu@codeaurora.org>
 <20180522091647.74884137@xps13>
Message-ID: <0df05f333a04a09af1ae1ee9cc2fa198@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-22 12:46, Miquel Raynal wrote:
> Hi Abhishek,
> 
> On Thu,  3 May 2018 17:50:34 +0530, Abhishek Sahu
> <absahu@codeaurora.org> wrote:
> 
>> parse_read_errors can be called with only oob_buf in which case
>> data_buf will be NULL.  If data_buf is NULL, then don’t
>> treat this page as completely erased in case of ECC uncorrectable
>> error for RS ECC. For BCH ECC, the controller itself tells
>> regarding erased page in status register.
>> 
>> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
>> ---
>> * Changes from v1:
>> 
>>   1. Added more detail in commit message
>>   2. Added comment before each if/else
> 
> Again, thanks for that.
> 
>> 
>>  drivers/mtd/nand/raw/qcom_nandc.c | 18 +++++++++++++++---
>>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

  Thanks Miquel for your review.

  Regards,
  Abhishek

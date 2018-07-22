Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD03C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FEE20858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i6C4BpN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FEE20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbeGVS76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 14:59:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730139AbeGVS76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 14:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aSQDs/3Vs+pBb3TVYyd7a0/bb8XCz7/EO+Cqj2obRKE=; b=i6C4BpN2PXpdiYWPKcyAg1Z5J
        +2eTiQSWLT0a/OHSBGzL9pyMSud5ImmLyv+x4U0llJCgUF5BBJD4aqLLZL60keA1Bmc7TLz1IZYgO
        QHDmJSS26QDubiWQadKGJzfA0Ra0ktcjmarK+307+3hGW2ZX9JjG9Qn7ShZA1mc9AIxKfykcD2xpV
        ViQpLo5GGMm5ZR2orRHgRq+AWLtoVkepyiP06wk108geHPx65wmSJ6aaacR7EqsP+gbKzc0WNBGoa
        cTHOKwR3ysX2ZUz/1d2qpYz+8jpRwzzNkOuknQHr0AtKwkYQWKJQ1U/Qk3JjSaRwTUbmv/7qtPL5U
        lfPTdN3jQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhIgd-0002ph-Oy; Sun, 22 Jul 2018 18:02:27 +0000
Subject: Re: [PATCH] arch/h8300: modify ffs(), fls() etc. functions to return
 int
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Richard Kuo <rkuo@codeaurora.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <1cdcd8e1-b12c-31cb-1188-c062dae3e461@infradead.org>
 <CAMuHMdVwY0b9S3j2MnuC59vYOuV=LXtQwnhevq227r+mec491Q@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <87467b7c-d361-034f-09d4-8694f26f80e0@infradead.org>
Date:   Sun, 22 Jul 2018 11:02:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVwY0b9S3j2MnuC59vYOuV=LXtQwnhevq227r+mec491Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/22/2018 02:25 AM, Geert Uytterhoeven wrote:
> CC hexagon
> 
> hexagon != H8/300 != SuperH
> 
> On Sat, Jul 21, 2018 at 5:28 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Building drivers/mtd/nand/raw/nandsim.c on arch/hexagon/ produces a
>> printk format build warning.  This is due to hexagon's ffs() being
>> coded as returning long instead of int.
>>
>> Fix the printk format warning by changing all of hexagon's ffx() and
>> flx() functions to return int instead of long.  The variables that
>> they return are already int instead of long.
>>
>> ../drivers/mtd/nand/raw/nandsim.c: In function 'init_nandsim':
>> ../drivers/mtd/nand/raw/nandsim.c:760:2: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'long int' [-Wformat]
>>
>>
>> There are no ffx() or flx() allmodconfig build errors after making this
>> change.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Rich Felker <dalias@libc.org>
>> Cc: linux-sh@vger.kernel.org
>> ---
>>  arch/hexagon/include/asm/bitops.h |   10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> --- linux-next-20180717.orig/arch/hexagon/include/asm/bitops.h
>> +++ linux-next-20180717/arch/hexagon/include/asm/bitops.h
>> @@ -194,7 +194,7 @@ static inline int __test_bit(int nr, con
>>   *
>>   * Undefined if no zero exists, so code should check against ~0UL first.
>>   */
>> -static inline long ffz(int x)
>> +static inline int ffz(int x)
>>  {
>>         int r;
>>
>> @@ -211,7 +211,7 @@ static inline long ffz(int x)
>>   * This is defined the same way as ffs.
>>   * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
>>   */
>> -static inline long fls(int x)
>> +static inline int fls(int x)
>>  {
>>         int r;
>>
>> @@ -232,7 +232,7 @@ static inline long fls(int x)
>>   * the libc and compiler builtin ffs routines, therefore
>>   * differs in spirit from the above ffz (man ffs).
>>   */
>> -static inline long ffs(int x)
>> +static inline int ffs(int x)
>>  {
>>         int r;
>>
>> @@ -254,7 +254,7 @@ static inline long ffs(int x)
>>   * bits_per_long assumed to be 32
>>   * numbering starts at 0 I think (instead of 1 like ffs)
>>   */
>> -static inline unsigned long __ffs(unsigned long word)
>> +static inline int __ffs(unsigned long word)
> 
> The version in asm-generic deoes use "unsigned long".
> 
> See also "m68k/bitops: convert __ffs to match generic declaration"
> https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/commit/?h=for-v4.19&id=4b538d3dca3e590cdb0234746011a6d9c245cfa3
> 
>>  {
>>         int num;
>>
>> @@ -272,7 +272,7 @@ static inline unsigned long __ffs(unsign
>>   * Undefined if no set bit exists, so code should check against 0 first.
>>   * bits_per_long assumed to be 32
>>   */
>> -static inline unsigned long __fls(unsigned long word)
>> +static inline int __fls(unsigned long word)
> 
> Same here

Hi Geert,

Thanks for all your catches here.  So ffs() and fls() return int,
while __ffs() and __fls() return unsigned long.

(hm, arch/arc/include/asm/bitops.h is a little different.)
(and unicore32)


I'll send a v2 patch (for hexagon).
That will still fix the printk format warning above.

>>  {
>>         int num;


-- 
~Randy

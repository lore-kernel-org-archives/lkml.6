Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65347C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5D3208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="wZ3uGxNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5D3208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934441AbeFROMC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:12:02 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:57606 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933134AbeFROL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:11:59 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 914F35C004D;
        Mon, 18 Jun 2018 16:11:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1529331116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uSkRQY0/+YfzgobovVe7/qsY8RnGhdBaCx0c1yP7wc4=;
        b=wZ3uGxNGyuoz7nEN9gwiXl7JjovNA4ZMLgIascH7yTeLkncpeA83ZKcz5Ur9AeGmccLdXE
        iqOZGs0Ek/corb5yEUTRN3nsKe21zLLRKFRsU4p5lT+uHgFFmsiwlBtUZCx9KO0GVo5EwY
        FmfVrbmt41VOf7xXaVy7omgU5OQFDKI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 18 Jun 2018 16:11:54 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, dev@lynxeye.de,
        miquel.raynal@bootlin.com, richard@nod.at, marcel@ziswiler.com,
        krzk@kernel.org, digetx@gmail.com, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, gaireg@gaireg.de,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] mtd: rawnand: add NVIDIA Tegra NAND flash support
In-Reply-To: <20180618135935.5a41ec6f@bbrezillon>
References: <20180617204605.4648-1-stefan@agner.ch>
 <20180618115806.7be25499@bbrezillon>
 <95279b61ce2630c1276669359b163933@agner.ch>
 <20180618135935.5a41ec6f@bbrezillon>
Message-ID: <40244fa25ef2d90a750bf8044d46c845@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-0.29 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[23];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.19)[71.04%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 18.06.2018 13:59, Boris Brezillon wrote:
> Hi Stefan,
> 
> On Mon, 18 Jun 2018 12:51:52 +0200
> Stefan Agner <stefan@agner.ch> wrote:
> 
>> On 18.06.2018 11:58, Boris Brezillon wrote:
>> > On Sun, 17 Jun 2018 22:45:59 +0200
>> > Stefan Agner <stefan@agner.ch> wrote:
>> >
>> >> Changes definitly calm down, most noteably probably the changes
>> >> around checking whether a page is empty if the stack reports ECC
>> >> errors.. I verified the code using raw nandwrites with OOB to
>> >> simulate an empty page which has some bits flipped in the OOB area,
>> >> everthing seems to work as I would expect it.
>> >>
>> >> For now I do not check extra OOB bytes since those are at variable
>> >> locations depending on algorithm.
>> >
>> > Hm, if you expose them as free OOB bytes, you should also check them,
>> > otherwise you might end up with corrupted data without noticing it. Note
>> > that, depending on whether those free OOB bytes are ECC-protected or
>> > not, you should change the way you do the check:
>> >
>> > - non-protected OOB bytes: all bytes should be 0xff (no bitflips
>> >   allowed)
>> > - data+free OOB bytes protected by the same ECC bytes: you should pass
>> >   the free OOB bytes buffer to nand_check_erased_ecc_chunk() along with
>> >   the data and ECC buffers
>> > - free OOB bytes have their own ECC bytes: call
>> >   nand_check_erased_ecc_chunk() separately and pass it the ECC + free
>> >   OOB buffers.
>>
>> This graphic taken from the public Tegra 2 Technical Reference Manual is
>> quite useful:
>> https://imgur.com/a/0Hqzbkc
> 
> Thanks for sharing this doc.
> 
>>
>> Tegra basically has all of the above, which makes the whole business
>> really tricky...
> 
> I'm not sure. Are "Skip bytes" protected by "main data parity bytes"?
> 
> AFAICT, you have "Tag bytes" that fall in case #3 and "Remaining spare
> bytes" that fall in case #1. If "Skip bytes" are protected by the "main
> data parity bytes", then it falls in case #2, otherwise it probably
> goes in case #1.
> 

Skip bytes are not protected. I think they are mainly meant to skip the
bad block marker. Only 4, 8, 12 or 16 bytes are supported.

>>
>> I am not sure if we really could do variant 1, non-protected OOB, but
>> since we have the option of protected OOB, we probably anyway would do
>> that.
> 
> That's up to you, but in this case, you should not declare those bytes
> as free (didn't check what is currently done in the driver).
> 
>>
>> RS/Hamming implements variant 3.
> 
> It seems to be a mix of #1 and #3, but I'm not sure (see above).
> 
>>
>> BCH implements variant 2.
> 
> I'd say it's a mix of #1 (skip + remaining bytes) and #2(tag bytes).
> 
>> OOB is protected with the last data buffer.
> 
> That would be weird, but maybe you're right. HW ECC engine usually
> split the OOB area in X portions, X being the number of ECC steps needed
> to cover a NAND page, and then have ECC bytes cover a sub-portion of
> data+OOB.
> 
> For example, for a NAND page of 2k with 64 bytes of OOB, and assuming
> the ECC step is 512bytes, you usually have something like:
> 
> [512(data)+8(protected-oob)+8(ecc)] x 4
> 

The TRM explicitly states so:

"BCH mode Error correction
- Error correction with involving spare only transfers is not supported.
ECC calculation of last sub-page includes tag data in spare area.
- Error correction with Main only transfers is supported.
- Maximum possible length of Tag data size is 252 bytes."


>>
>> So this would require a algorithm depending implementation, which is
>> probably not a big deal.
> 
> True.
> 
>>
>> But there is one more issue with BCH: Only if extra data are actually
>> transferred, tag space is actually allocated. If no tag bytes are
>> transferred, parity follows immediately skip bytes. As far as I know the
>> MTD stacks OOB layout assumes that is always the same layout, no matter
>> whether we write extra OOB data or not. For the Tegra NAND controller
>> this would mean that we have to always transfer tag bytes and therefor
>> penalize the use case we are most interested in (which is no extra OOB
>> bytes, since UBI does not make use of it)...
> 
> Hm, given the amount of tag bytes I don't think you'll have a huge
> penalty, so I'd recommend always sending those bytes. Alternatively,
> you could decide that you never want to have those tag bytes and expose
> none of them.
> 
>>
>> Furthermore I realized that testing is not easily possible since
>> nandwrite with --oob seems not to make use of "oob_required" in the main
>> page write but issues a separate OOB write command. I did not found a
>> way to issue a write from user space which sets oob_required...
> 
> Maybe it's time to patch those tools. The ioctl exists, so it's just a
> matter of using it in nandwrite/mtd-utils.
> 
>>
>> Due to all this I rather prefer to not implement extra OOB support at
>> this point.
> 
> I'm fine with that, but that means no JFFS2 support, as I think JFFS2
> wants to place some of its metadata in the OOB area. Also, I fear it
> will be a mess to add support for that kind of things without breaking
> existing setup afterwards, so, by taking this decision you're pretty
> much saying that this controller will never expose free OOB bytes.
> That's not a problem from my PoV, but I want you to be aware of that.
> 

We already operate without extra OOB byte support in our downstream BSP.
I'd rather have a easy upgrade path today...

Another issue I just realized: The boot ROM only supports BCH without
tag bytes... So at least the boot loader has to be written without tag
bytes.

>>
>> How do I do this properly? Set mtd_ooblayout_ops.free to NULL?
> 
> Just implement a dummy function that returns -ERANGE.
> 

Ok, I will go with this then.

Also, thanks for all your valuable feedback, really appreciated!

--
Stefan

Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F013C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341E221721
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HiBMKHjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbeLXJaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:30:05 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35246 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbeLXJaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:30:04 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181224093002euoutp022281a3f140e2cb4af7c4499b0ab0f551~zOtlP5KEO0596105961euoutp02w
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 09:30:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181224093002euoutp022281a3f140e2cb4af7c4499b0ab0f551~zOtlP5KEO0596105961euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545643802;
        bh=uAKEEZEm1A2pmlHTGKCqg24LBajq+uqGaTQ4RjOlC3A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HiBMKHjwK8Rlg4AHI5o++ft7OIpIdRgPSM6dBnrGK4U3AR0JdMPNLfbbgibzzRhvZ
         NCorzaaK6ZRmxgTb9TxLPJlHCSOFLJ53euLhMAGRRwwhaeFX/GWpKJJNhuc1vUih21
         7wtjy1DkUnVCyicwGH23UH3/r6Zs928KQIv4V70Y=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181224093001eucas1p2400b6063cfb3905af1c46c82d78ddfd7~zOtkcTySA0464004640eucas1p2T;
        Mon, 24 Dec 2018 09:30:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 59.41.04441.817A02C5; Mon, 24
        Dec 2018 09:30:00 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181224093000eucas1p2ac8ad8921d120983a3339614f0d2cd95~zOtjmbya40456004560eucas1p2e;
        Mon, 24 Dec 2018 09:30:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181224093000eusmtrp2a6db03670b1c7bd3a73f3b5c3f587745~zOtjXkr_31235812358eusmtrp2K;
        Mon, 24 Dec 2018 09:30:00 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-02-5c20a7189009
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CC.61.04128.817A02C5; Mon, 24
        Dec 2018 09:30:00 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181224092959eusmtip1c998ab28f2b2d4b275b38f8f09c5711c~zOti7KvSj2193121931eusmtip1O;
        Mon, 24 Dec 2018 09:29:59 +0000 (GMT)
Subject: Re: [PATCH v4 1/3] driver core: add probe_err log helper
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <32da3ba6-5662-f468-ae84-debf52f61bd2@samsung.com>
Date:   Mon, 24 Dec 2018 10:29:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfSxVYRz2Ovece9xcOy52f7usuM3Wx7pY/XG2Gln9cfqnj7W1VlZdnGG5
        6B6EZoy6Ls1HDXERUrumdMvXkNIuc4V8RmimuMrnVFhLk1yH5b/n9zzP+3uf591LYpIuXEaG
        hEWy6jBlqJwQCerafncfAr2rn+erUZqeyWpB9Ms8A07nfDETdHKZgaBLc/WIrpocwumBxkKC
        Nua8RnRl65iQLlrOwej1pnrh8V3MwFAfxjToxoRMVUUqwTQXPRMy1Y8TmMU3gwSTUVOBmKWq
        3WfJS6JjgWxoSDSr9vC+JgqemS4QRNQcjDG0a7BEdFuehmxIoI7Aj6QVLA2JSAlVjiAjM4ng
        h2UE5ukMIT8sIUjOLBVuH9FmabYEPYKW1VlrflhA0KVfQxaXA+ULoz2zm9iRcoM/mlzcYsKo
        RQxSCrOtLQJB7Ye16hHCgsWUN9z7lSewYAHlDvUpZZseJ+oiaMefbnns4V2+edNjQ52DzjuF
        uAVj1B5Iri3AeCyFUXOxNR91RgglBv80RG7gkzC/dIGnHWDWVLPVxgXWG7btCZCU/2HzMYDS
        Imgv0xO8cBRaTH24ZQ+2kdnQ6MHTvvCiL0fIr7eD4QV7PoEd3K97gPG0GLQaCe92g/H3tRiP
        pfCkd4XIQnLdjl66HV10O7ro/t9bggQVSMpGcaoglvMKY28qOKWKiwoLUgSEq6rQxh/r/Gv6
        WY9W+v2NiCKR3FYcI3P1k+DKaC5WZURAYnJH8UO0QYkDlbFxrDr8qjoqlOWMyJkUyKXiW1af
        L0uoIGUke51lI1j1tmpN2sgSUfkJg5I+f0phy0Wk9024ywPinG1by4Pd0k1S07e56DlHqi1h
        cE3RPPVWY9V0ptZqnhmbfrQ8ZO8zudCdF+jk1tOhyPbEDSLwj3c5PdzRuuqQKu5d3Hvja4Ih
        uwBvNK/1X2HrG+/ah8dX7pvQyj5NHR7xCSkref6xGJd9H0h8JBdwwUqvA5iaU/4DOQYAl18D
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsVy+t/xu7oSyxViDO6dY7V4OeEwo8XGGetZ
        LaY+fMJm0bx4PZvFwmnLGS02Pb7GanF51xw2i0NT9zJarD1yl91i7pepzBb/9+xgd+D2uHzt
        IrPHzll32T02repk89g/dw27x+Yl9R7v911l8+jbsorR4/MmuQCOKD2bovzSklSFjPziElul
        aEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mly9msxRs0a5Yf6KNuYGxRamL
        kZNDQsBEomNCG3sXIxeHkMBSRokzExuYIRLiErvnv4WyhSX+XOtigyh6zShx49ZdsISwgKPE
        rfOvGEFsEQFFid9t01hBipgFPjJLbDz3GqrjFpPE2ts/2UGq2AQ0Jf5uvskGYvMK2ElM/D6D
        BcRmEVCV2NG+mAnEFhWIkDj7ch0jRI2gxMmZT8BqOAUCJU63zmEFsZkF1CX+zLvEDGHLSzRv
        nQ1li0vcejKfaQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsY
        gdG77djPLTsYu94FH2IU4GBU4uGtkFKIEWJNLCuuzD3EKMHBrCTCO48RKMSbklhZlVqUH19U
        mpNafIjRFOi5icxSosn5wMSSVxJvaGpobmFpaG5sbmxmoSTOe96gMkpIID2xJDU7NbUgtQim
        j4mDU6qBcYOqd5TjI5Ullxf2HQqUva7G5cIv/27l/emVWfJ6Ml8CDsfbxP584Lv9jVav3YRv
        q1e2yO0IkbnoHqftc1Ugg2Wr6e1bNfn3vdtr256sKAqfYXooz3f7KcGz705tZfob+cl00qNr
        1R2zlhx4xvhh+a599btmNNo/CPqZqu58z3p6/G63x3d4lyixFGckGmoxFxUnAgCBroak9AIA
        AA==
X-CMS-MailID: 20181224093000eucas1p2ac8ad8921d120983a3339614f0d2cd95
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181220102259eucas1p2f748c68e01cd4e09a266da879722e218
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181220102259eucas1p2f748c68e01cd4e09a266da879722e218
References: <20181220102247.4911-1-a.hajda@samsung.com>
        <CGME20181220102259eucas1p2f748c68e01cd4e09a266da879722e218@eucas1p2.samsung.com>
        <20181220102247.4911-2-a.hajda@samsung.com>
        <20181220111403.GB10978@kroah.com>
        <b9f7cb75-62a0-20f6-0e5b-1553852d81b2@samsung.com>
        <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.12.2018 23:47, Rob Herring wrote:
> On Thu, Dec 20, 2018 at 5:38 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>> On 20.12.2018 12:14, Greg Kroah-Hartman wrote:
>>> On Thu, Dec 20, 2018 at 11:22:45AM +0100, Andrzej Hajda wrote:
>>>> During probe every time driver gets resource it should usually check for error
>>>> printk some message if it is not -EPROBE_DEFER and return the error. This
>>>> pattern is simple but requires adding few lines after any resource acquisition
>>>> code, as a result it is often omited or implemented only partially.
>>>> probe_err helps to replace such code sequences with simple call, so code:
>>>>      if (err != -EPROBE_DEFER)
>>>>              dev_err(dev, ...);
>>>>      return err;
>>>> becomes:
>>>>      return probe_err(dev, err, ...);
>>> Can you show a driver being converted to use this to show if it really
>>> will save a bunch of lines and make things simpler?  Usually you are
>>> requesting lots of resources so you need to do more than just return,
>>> you need to clean stuff up first.
>>
>> I have posted sample conversion patch (generated by cocci) in previous
>> version of this patchset [1].
>>
>> I did not re-posted it again as it is quite big patch and it will not be
>> applied without prior splitting it per subsystem.
>>
>> Regarding stuff cleaning: devm_* usually makes it unnecessary, but also
>> even with necessary cleaning you can profit from probe_err, you just
>> calls it without leaving probe - you have still handled correctly probe
>> deferring.
>>
>> Here is sample usage (taken from beginning of the mentioned patch):
>>
>> ---
>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
>> index 4b900fc659f7..52e891fe1586 100644
>> --- a/drivers/ata/libahci_platform.c
>> +++ b/drivers/ata/libahci_platform.c
>> @@ -581,11 +581,8 @@ int ahci_platform_init_host(struct platform_device *pdev,
>>         int i, irq, n_ports, rc;
>>
>>         irq = platform_get_irq(pdev, 0);
>> -       if (irq <= 0) {
>> -               if (irq != -EPROBE_DEFER)
>> -                       dev_err(dev, "no irq\n");
>> -               return irq;
>> -       }
>> +       if (irq <= 0)
>> +               return probe_err(dev, irq, "no irq\n");
> Shouldn't platform_get_irq (or what it calls) print the error message
> (like we do for kmalloc), rather than every driver? We could get rid
> of lots of error strings that way. I guess there are cases where no
> irq is not an error and we wouldn't want to always print an error. In
> some cases like that, we have 2 versions of the function.


kmalloc prints error and stack trace because it shows shortage of common
resource used by everyone, quite different thing than irq specific for
given device. Usually only device driver knows if error in irq acquiring
should be reported to user, and how it should be reported.

The example is for irq, but the question about the best way of reporting
error stands for all other resource acquisitions: gpios, regulators,
clocks,....

Alternative ways I see for now:

1. Do it in the consumer, like it is done now - in such case probe_err
seems to be a good helper.

2. Do it in the provider's framework, in such case framework should know
if the error should be printed:

  a) by calling special versions of all allocators,

  b) by adding extra argument to all allocators,

  c) adding extra flag to struct device (it is passed to most allocators)

3. By creating generic allocator for multiple resources, something
similar to what I have proposed few years ago in "resource tracking"
framework [1]. For example:

  ret = devm_resources_get(dev,

    res_irq_desc(&ctx->irq, 0),

    res_clk_desc(&ctx->clk, "bus_clk"),

    res_gpio_desc(&ctx->enable_gpio, "enable", GPIOD_OUT_HIGH),

    ...

  );

  Error reporting would be performed in this universal allocator.


If we want to perform brave changes I would opt for 3 - it is very
common to allocate multiple resources in probe, compacting it into one
helper should significantly simplify the code.

Option 1 is the simplest one - we do not change existing practices - so
it is the best in case of conservative approach.

I have mixed feelings about 2c, practically it looks quite tempting - we
get what we want with minimal effort, but I am not sure if polluting
struct device with 'presentation' layer is a good solution.

I do not like 2a neither 2b - alternatives between function namespace
pollution and argument list pollution.


[1]: https://lwn.net/Articles/625454/


> Not what you're addressing here exactly, but what I'd like to see is
> the ability to print the exact locations generating errors in the
> first place. That would require wrapping all the error code
> assignments and returns (or at least the common sources). If we're
> going to make tree wide changes, then that might be the better place
> to put the effort. If we had that, then maybe we'd need a lot fewer
> error messages in drivers. I did a prototype implementation and
> coccinelle script a while back that I could dust off if there's
> interest. It was helpful in finding the source of errors, but did have
> some false positives printed.


I guess that in case of resource acquisition it is usually easy to
locate place the error was reported, if the error message is informative
enough, exact line number/function name seems to me overkill.


Regards

Andrzej



>
> Rob
>
>


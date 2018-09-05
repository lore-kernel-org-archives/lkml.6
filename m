Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2442CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 03:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C6D2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 03:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="dyWvTgwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C6D2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeIEHzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 03:55:48 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43833 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbeIEHzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 03:55:48 -0400
Received: by mail-yb1-f193.google.com with SMTP id k5-v6so2141475ybo.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 20:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QOCnZbyzmr6xs+c4mZtIc74zeiICZDvrCsymiTx5XTY=;
        b=dyWvTgwfQkriDP87ZMLpCjmYbjw9ZhU2zE5AmKwPbYoYQE1ylnBhi2aYnB1tIxUk6r
         fuHZvjSP04vszKcJUD51/HcU3DaDNshXAk8I8jjxwdIeFXRxwGeq1cA9ytcJ09DoTzDj
         mk7KNipiN4/E9NLnN2BQYr/A9fWAIILVMj8a2NjbXOihXgs+jnnzRsSm3XeSrzKhJZWk
         R73Py2ujEj3Be4AQlKDfyspcbP6WToz/kgSyUTHvRuFJ3oHfshn+3oq9DD1ft/tAiNKI
         e4tg5V5MN4QAnsGUyXn29iN88rPymNfCXzyZGkNp3RfC7TI0bBeF1fe/E3rnNkER5S0+
         bvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QOCnZbyzmr6xs+c4mZtIc74zeiICZDvrCsymiTx5XTY=;
        b=mW2+f8IhIMheQ8GEa+zxRo6KQ6hdcpf6vMOpiHhnE67yhxeJTb/XoSILTrQWDiw5pH
         vf+QRovnnG6QsZaFrRKBj44TIYyikIlkL5m82xzZtYJdZb1b72fz2LJiMhufWPBE56a5
         GAXtCBlDYSFQ26o0eJiN2/1R7hhODJcDyZ43UZabDZUTAbwA3TFxob/5nTaULH9BIcC1
         7j7elJCrNAZx1gWGeL35ZeYUDYif2bBd6mLcLFyDQ/TGwjL7kt+vAsml4TQJyqPWDPSK
         git6XpyzUvpvKoMarCiF7oMJ2k2wt/ZBrFLzc/erMwZaj4abUFz/W1rTJQRSvaVEomRI
         7isQ==
X-Gm-Message-State: APzg51CulfIDu8dZHxZWQFL57yZWm5fKrFwq4mTpZtqBlwMjdNFSsNXK
        npi5IxkMSPdT9R5grYO4/bGx44lhvwE3glaZomUNMQ==
X-Google-Smtp-Source: ANB0VdZT0huOrlhyRBZvEYKOe6tNiSdVqBWCJxJx0SXa4EWPjmzB2zZ9tG8k0/lvs9V2sAAvrAEn0kH+L76nuWB2UnY=
X-Received: by 2002:a25:dd2:: with SMTP id 201-v6mr17758259ybn.301.1536118064116;
 Tue, 04 Sep 2018 20:27:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:e106:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 20:27:43 -0700 (PDT)
In-Reply-To: <20180905010100.GN29121@lunn.ch>
References: <20180905001535.19168-1-mdf@kernel.org> <20180905010100.GN29121@lunn.ch>
From:   Moritz Fischer <moritz.fischer@ettus.com>
Date:   Tue, 4 Sep 2018 20:27:43 -0700
Message-ID: <CAAtXAHdu1a5dTP8rd7+Oc2--5F-nU5E6M796KZKd8croYcLVoQ@mail.gmail.com>
Subject: Re: [RFC/PATCH] net: nixge: Add PHYLINK support
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alex Williams <alex.williams@ni.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, Sep 4, 2018 at 6:01 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> 3) I'm again not sure about the 'select PHYLINK', wouldn't
>>    wanna break the build again...
>
> Hi Moritz
>
> I think it is safe. PHYLINK has no stated dependencies on OF. But i
> suspect it currently is pretty useless without OF.

Ok, great. Thanks!

>> @@ -1286,7 +1329,13 @@ static int nixge_probe(struct platform_device *pdev)
>>       priv->coalesce_count_rx = XAXIDMA_DFT_RX_THRESHOLD;
>>       priv->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
>>
>> -     err = nixge_mdio_setup(priv, pdev->dev.of_node);
>> +     mn = of_get_child_by_name(pdev->dev.of_node, "mdio");
>> +     if (!mn) {
>> +             dev_warn(&pdev->dev, "No \"mdio\" subnode found, defaulting to legacy\n");
>> +             mn = pdev->dev.of_node;
>> +     }
>> +
>> +     err = nixge_mdio_setup(priv, mn);
>
> I would suggest making this a patch of its own.

Yeah, will do.
> Also, do you need the legacy behaviour? If there are no boards out in
> the wild which this will break, just make the change.

Well all users basically use devicetree overlays that we distribute
with the FPGA images
as part of a filesystem update. So I suppose it wouldn't break anyone,
yet... It would certainly
make the code easier to read.

> Please also update the device tree binding documentation.

Yeah will do.

Thanks for the feedback,

Moritz

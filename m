Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDCBC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181882154F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7Pp59DN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181882154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbeHNWzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 18:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728034AbeHNWzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 18:55:25 -0400
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com [209.85.161.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D873321732;
        Tue, 14 Aug 2018 20:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534277196;
        bh=llUhC2Q3Xmjgdce6sDBHyN9Kr+GHhvlze3CG88si/uc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=i7Pp59DNk1u7hhcGrDIKgw6lzyU0aaWFmGwY+ihrZ4fWZFqiG6rgZ8gVZ/areCIZL
         UAd0cpHuRbSgXq++ISLKtBPq32so9ipyb118W56+yzon64uinEaqbibJxswAumjCv1
         1s30aEuxxeTYcQVq3WXj7K++tINlyiKxMyIXjGcA=
Received: by mail-yw1-f44.google.com with SMTP id l189-v6so17156780ywb.10;
        Tue, 14 Aug 2018 13:06:35 -0700 (PDT)
X-Gm-Message-State: AOUpUlGGaH197Ddo9f1RqrE1GOkFObgrueEj6OuCtv/rdP19yomYthIp
        G9M/XX6UNI7ZNewIu7fStf6Dndk/FsQJTjyB3gY=
X-Google-Smtp-Source: AA+uWPxbg1FLhZCesDlXAmN9g5jsheooSOwDROyxrgpW8pNP7goDWPrnim5pf3rqzqRhHCpivq3y/qqnsV2eGshaoUw=
X-Received: by 2002:a25:f817:: with SMTP id u23-v6mr12248047ybd.62.1534277195039;
 Tue, 14 Aug 2018 13:06:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:81cc:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 13:05:54
 -0700 (PDT)
In-Reply-To: <20180814161917.GA26926@rob-hp-laptop>
References: <20180801100457.25614-1-nava.manne@xilinx.com> <20180814161917.GA26926@rob-hp-laptop>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 14 Aug 2018 15:05:54 -0500
X-Gmail-Original-Message-ID: <CANk1AXT6RkuFhWoFBy127j2Q=h9P-1S=0Mhyh9=PMJyC72sciQ@mail.gmail.com>
Message-ID: <CANk1AXT6RkuFhWoFBy127j2Q=h9P-1S=0Mhyh9=PMJyC72sciQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] ARM: dt: fpga: Added binding docs for Xilinx
 zynqmp FPGA manager
To:     Rob Herring <robh@kernel.org>
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        kishore m <chinnikishore369@gmail.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 11:19 AM, Rob Herring <robh@kernel.org> wrote:

Hi Nava,

I didn't see this posting because it wasn't sent to my current email
address or to the linux-fpga mailing list.  People's email address
change at random times, so the easiest way to keep up is to always
check out the linux-next repo's master branch and look at the latest
MAINTAINERS file there.  Also there's a handy
./scripts/get_maintainer.pl script to make sure you include the right
people.

Alan

> On Wed, Aug 01, 2018 at 03:34:56PM +0530, Nava kishore Manne wrote:
>> New bindings document for zynqmp fpga manager.
>>
>> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
>> ---
>>  .../devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>>
>> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>> new file mode 100644
>> index 000000000000..0eac747747f5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>> @@ -0,0 +1,9 @@
>> +Xilinx Zynqmp FPGA Manager
>> +
>> +Required properties:
>> +- compatible:                should contain "xlnx,zynqmp-pcap-fpga"
>> +
>> +Example:
>> +     pcap: pcap@00 {
>> +             compatible = "xlnx,zynqmp-pcap-fpga";
>
> How is this accessed? Via firmware interface? If so, need to define it
> is a child of the firmware node.
>
>> +     };
>> --
>> 2.18.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

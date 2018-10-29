Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68374C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D378820873
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MmS5gqQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D378820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbeJ2Rv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:51:59 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15278 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbeJ2Rv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:51:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bd6cd010001>; Mon, 29 Oct 2018 02:04:02 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 29 Oct 2018 02:04:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 29 Oct 2018 02:04:14 -0700
Received: from [10.21.24.173] (10.21.24.173) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 29 Oct
 2018 09:04:10 +0000
Subject: Re: [PATCH 0/9] serial: Add Tegra Combined UART driver
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jslaby@suse.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Mika Liljeberg <mliljeberg@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
From:   Pekka Pessi <ppessi@nvidia.com>
Message-ID: <85092b49-2b62-bd76-05a3-521415835b6e@nvidia.com>
Date:   Mon, 29 Oct 2018 11:04:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181026111638.10759-1-thierry.reding@gmail.com>
X-Originating-IP: [10.21.24.173]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To HQMAIL101.nvidia.com
 (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1540803842; bh=g9fWBiSc02a1fPF49MCKvWeS8mTtA11H9ffVxwOST7o=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=MmS5gqQ6j7rYafiRLUCzi/DmZzR3epOSMLnLuJBAOEoWHIqh0DmMLVU/xXjE6cxgU
         ZW5gkUGyM/3Ht23rHfKpCsynVYum+7AGw9xfC1DLYkQ6Bd0kM3j1o/cfnO6/7TUlqu
         NlPHHn9zvlzQcJwtfs/MhJDjQ0vJFmY1G3GO7Y7pClmTCpZCzg53IBaq16e1jmFFWB
         urvSv+IZ9kysZfp90Mj2c5W3hqDxkG8xmgrh8VfM7HN4DAty704CEfvxn1DV49ehBa
         E8y3ZLgEyqSG+jqdIgJlywT5lNPm1J3X60+hbgaKAAtNFs/Jc3M58KA5ET9IeOp3tm
         BvPnmxQ21jziQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

What is the use case for the mailbox driver? What kind of entity will be 
there consuming sent messages and sending messages to kernel?

--Pekka

On 10/26/2018 02:16 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Hi everyone,
>
> this is a reworked version of Mikko's earlier proposal[0]. I've reworked
> the TCU driver itself so that it relies less on global variables as well
> as added a Kconfig option to allow the console support to be selected. I
> also fixed a couple of issues that manifested themselves as I was moving
> towards the IRQ driven mode (TCU was passing a pointer to a local
> variable which was getting stored in the mailbox's ring buffer and the
> data pointed at was becoming stale by the time the mailbox got around to
> dequeue it).
>
> The biggest bulk of the changes is in the mailbox driver. This series
> addresses all of Jassi's comments from back at the time. One notable
> additional change is that shared mailboxes are now interrupt driven,
> which removes the need for polling mode.
>
> Unfortunately there is still an issue because the TCU uses the mailbox
> in atomic context for both TTY and console modes, so we get a sleeping-
> while-atomic BUG when using mbox_client->tx_block = true in order to
> rate-limit mbox_send_message(). In order to work around this, I added a
> mechanism to mbox_send_message() that will allow blocking from atomic
> context if the mailbox controller implements the new ->flush() callback.
> For Tegra HSP shared mailboxes this is done by spinning on the shared
> mailbox register until the receiver has marked the mailbox as empty. I
> have been running this locally for a couple of days now and it works
> perfectly.
>
> Furthermore this series incorporates Mikko's work in progress on
> splitting up the mailbox controllers and allowing multiple controllers
> to match on the same device tree node during mbox_request_channel().
>
> Last but not least there are no build-time dependencies between the
> mailbox and serial drivers, so I think the easiest way to merge this is
> if Jassi picks up patches 1-5, Greg takes patches 6 & 7 and I pick up
> patches 8-9 into the Tegra tree.
>
> Thanks,
> Thierry
>
> [0]: https://lore.kernel.org/patchwork/project/lkml/list/?series=357641
>
> Mikko Perttunen (5):
>    mailbox: Allow multiple controllers per device
>    dt-bindings: tegra186-hsp: Add shared interrupts
>    dt-bindings: serial: Add bindings for nvidia,tegra194-tcu
>    arm64: tegra: Add nodes for TCU on Tegra194
>    arm64: tegra: Mark TCU as primary serial port on Tegra194 P2888
>
> Thierry Reding (4):
>    mailbox: Support blocking transfers in atomic context
>    mailbox: tegra-hsp: Add support for shared mailboxes
>    mailbox: tegra-hsp: Add suspend/resume support
>    serial: Add Tegra Combined UART driver
>
>   .../bindings/mailbox/nvidia,tegra186-hsp.txt  |   3 +
>   .../bindings/serial/nvidia,tegra194-tcu.txt   |  35 ++
>   .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi |   2 +-
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  38 +-
>   drivers/mailbox/mailbox.c                     |  11 +-
>   drivers/mailbox/tegra-hsp.c                   | 495 +++++++++++++++---
>   drivers/tty/serial/Kconfig                    |  22 +
>   drivers/tty/serial/Makefile                   |   1 +
>   drivers/tty/serial/tegra-tcu.c                | 299 +++++++++++
>   include/linux/mailbox_controller.h            |   4 +
>   include/uapi/linux/serial_core.h              |   3 +
>   11 files changed, 847 insertions(+), 66 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
>   create mode 100644 drivers/tty/serial/tegra-tcu.c
>


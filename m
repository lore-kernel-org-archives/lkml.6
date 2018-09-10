Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,SUBJ_ALL_CAPS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D8CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E06920866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E06920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeIJRPJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:15:09 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.65]:7181 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727727AbeIJRPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:15:09 -0400
Received: from [46.226.52.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-west-1.aws.symcld.net id E9/B1-27030-CB1669B5; Mon, 10 Sep 2018 12:21:16 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+JIrShJLcpLzFFi42KJ27nUWHdP4rR
  og2cH1CzmHznHatG8eD2bxZvj05ksulbvZLG4dqyXyeLyrjlsFouWtTJbPFl4hsli6fWLTBat
  e4+wO3B5rJm3htFj06pONo95JwM99s9dw+6x8d0OJo/3+66yeez83sDu8XmTXABHFGtmXlJ+R
  QJrxp2uZpaCRZwVP+/2MjYwrmXvYuTiEBJYyihxaGoDcxcjJwebgIXE5BMP2EASIgKnmSS+f+
  xjBnGYBd4zSvR++skCUiUsoCux4NFtdhBbREBPYsGtOYwQtpHEhq+/mUBsFgFViV3rNgE1c3D
  wCgRI7OjSAQkLCbhJNG1dClbOKeAu8W7aCbCRjAKyEl8aV4MdwSwgLnHryXywMRICAhJL9pxn
  hrBFJV4+/scKYctLbP/2mx3Ctpd4fe8dC8gqCQF9ib7GYoiwocSqaQdYIGxziTczd0KN15FYs
  PsTG4StLbFs4WuwOK+AoMTJmU9YJjCKz0JyxSwkLbOQtMxC0rKAkWUVo0VSUWZ6RkluYmaOrq
  GBga6hoZGuoaUFEJvpJVbpJumlluqWpxaX6BrqJZYX6xVX5ibnpOjlpZZsYgSmhpSCY0d2MJ7
  uSj/EKMnBpCTKK6E4LVqILyk/pTIjsTgjvqg0J7X4EKMMB4eSBO/aBKCcYFFqempFWmYOMEnB
  pCU4eJREeFeCpHmLCxJzizPTIVKnGC05WiZPnsTM8ef9VCC5r3vaJGYhlrz8vFQpcd4skAYBk
  IaM0jy4cbBEeolRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMG8JyBSezLwSuK2vgA5iAjpo3f
  kpIAeVJCKkpBoYp2n/6zw9ce0FtkkT+DIumUjOPvX3oOj6dinRkNRj7FUvayNUvCq2n1Nn9/8
  0LWGJ6znpvLPMXU3RLdOf/fnsHxItUiQV9aXdQy39w6l7/Cx352TkXI18rvhg63u9qD9WWbe7
  ZINiFqpMeLwlM7R6wbodf+ZuVHO/2h3xujm4cIliv6X6pTxlJZbijERDLeai4kQA7z2AJp8DA
  AA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-4.tower-282.messagelabs.com!1536582076!6811838!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12848 invoked from network); 10 Sep 2018 12:21:16 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub01.diasemi.com) (94.185.165.51)
  by server-4.tower-282.messagelabs.com with AES128-SHA encrypted SMTP; 10 Sep 2018 12:21:16 -0000
Received: from SW-EX-MBX01.diasemi.com ([169.254.3.12]) by
 sw-ex-cashub01.diasemi.com ([10.20.16.141]) with mapi id 14.03.0382.000; Mon,
 10 Sep 2018 13:21:15 +0100
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Li Jun" <jun.li@nxp.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Support Opensource" <Support.Opensource@diasemi.com>
Subject: RE: [PATCH 0/3] *** SUBJECT HERE ***
Thread-Topic: [PATCH 0/3] *** SUBJECT HERE ***
Thread-Index: AQHUSQCB1dt9WSNaiEmn19Sym7Y3eaTpbzuw
Date:   Mon, 10 Sep 2018 12:21:14 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337019831680C@SW-EX-MBX01.diasemi.com>
References: <cover.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 10/09/2018 11:14:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 September 2018 13:19, Adam Thomson wrote:

> This patch set adds DT bindings support for PPS APDOs, and updates the FUSB302
> to use the generic connector bindings allowing for PPS support in this Type-C
> port controller. Existing FUSB302 device specific bindings still work, but
> are now deprecated in favour of the generic connector approach.

Please ignore as suffering finger trouble. Will resend with patches corrected.

> 
> Changes in v2:
> 	- Added Reviewed-by tags to patches
> 	- Rebase code against latest usb-next branch (v4.19-rc2)
> 
> Adam Thomson (3):
>   dt-bindings: connector: Add support for USB-PD PPS APDOs to bindings
>   dt-bindings: usb: fusb302: Use usb-connector bindings for
>     configuration
>   usb: typec: fusb302: Populate tcpc fwnode for TCPM property handling
> 
>  .../bindings/connector/usb-connector.txt           |  8 +++---
>  .../devicetree/bindings/usb/fcs,fusb302.txt        | 32 +++++++++++++++++-----
>  drivers/usb/typec/fusb302/fusb302.c                |  3 ++
>  include/dt-bindings/usb/pd.h                       | 26 ++++++++++++++++++
>  4 files changed, 58 insertions(+), 11 deletions(-)
> 
> --
> 1.9.1


Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE67C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1D420866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1D420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeIKToV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:44:21 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:6876 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727680AbeIKToV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:44:21 -0400
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id DE/9D-18431-9D4D79B5; Tue, 11 Sep 2018 14:44:41 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRWlGSWpSXmKPExsUSt3Opse6NK9O
  jDZbtNbCYf+Qcq0Xz4vVsFm+OT2ey6Fq9k8Xi2rFeJovLu+awWSxa1sps8WThGSaLpdcvMlm0
  7j3C7sDlsWbeGkaPTas62TzmnQz02D93DbvHxnc7mDze77vK5rHzewO7x+dNcgEcUayZeUn5F
  QmsGe1bawoOs1XcaLnN3MC4nbWLkYtDSGApo8TOg7uAHE4ONgELicknHrCB2CICWRKTty5nAi
  liFjjDLHF+4nUgh4NDWCBR4tZxqJokiS2Pp7FA2EYS62Z0gcVZBFQl/r36AFbOKxAgceUnH0h
  YSOAio8TBeZYgYU4Bc4m+b7IgYUYBWYkvjauZQWxmAXGJW0/mM4HYEgICEkv2nGeGsEUlXj7+
  xwphy0ts//abHcK2l3h97x0LhK0v8ejxI0YI21Bi1bQDUHFzidNbtkPN15FYsPsTG4StLbFs4
  WuwOK+AoMTJmU9YJjCKz0JyxiwkLbOQtMxC0rKAkWUVo0VSUWZ6RkluYmaOrqGBga6hoZGuoa
  WxrqGZiV5ilW6iXmqpbnlqcYmuoV5iebFecWVuck6KXl5qySZGYFJIKTi4ZAfjo+XphxglOZi
  URHmXnJkeLcSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mC9/lloJxgUWp6akVaZg4wPcGkJTh4lER4
  RUDSvMUFibnFmekQqVOMuhx/3k+dxCzEkpeflyolznsPpEgApCijNA9uBCxVXmKUlRLmZWRgY
  BDiKUgtys0sQZV/xSjOwagkzDsZZApPZl4J3KZXQEcwAR2x7vwUkCNKEhFSUg2MRqy+DL/DWt
  NvXnw/16bQ69/3dGUVs6KTVwKcDl/Mnx6sUXd0UsA3zg2+xnUJWjtvZXC12s+TZ17+ewnfgll
  TG162hHXpbbvyxahIOTg0cW96otZz8fl9bqsv1V78os7buzdjbSPb+lkKShf+3rpS8X3206kZ
  65pk5P6vWHxy4Sz5h5r2sZsVlViKMxINtZiLihMBAyquzpADAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-18.tower-268.messagelabs.com!1536677080!7006632!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30876 invoked from network); 11 Sep 2018 14:44:40 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub02.diasemi.com) (94.185.165.51)
  by server-18.tower-268.messagelabs.com with AES128-SHA encrypted SMTP; 11 Sep 2018 14:44:40 -0000
Received: from SW-EX-MBX01.diasemi.com ([169.254.3.12]) by
 sw-ex-cashub02.diasemi.com ([10.20.16.142]) with mapi id 14.03.0382.000; Tue,
 11 Sep 2018 15:44:39 +0100
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>, Li Jun <jun.li@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Support Opensource" <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v2 1/3] dt-bindings: connector: Add support for USB-PD
 PPS APDOs to bindings
Thread-Topic: [PATCH v2 1/3] dt-bindings: connector: Add support for USB-PD
 PPS APDOs to bindings
Thread-Index: AQHUSdybH3m3gFv6uEOiBqh3JaIJTqTrJwbw
Date:   Tue, 11 Sep 2018 14:44:38 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03370198316AA7@SW-EX-MBX01.diasemi.com>
References: <cover.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
 <b98c58ca3681d18f44359431a1ccec2fa34023d1.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
 <20180911143446.GC22723@kuha.fi.intel.com>
In-Reply-To: <20180911143446.GC22723@kuha.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub02.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 11/09/2018 11:03:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 September 2018 15:35, Heikki Krogerus wrote:

> Hi Adam,
> 
> On Mon, Sep 10, 2018 at 01:24:26PM +0100, Adam Thomson wrote:
> > Add support for PPS APDOs to connector bindings so a port controller
> > can specify support for PPS, as per existing FIXED/BATT/VAR PDOs.
> >
> > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> I've applied this patch to my tree:
> https://github.com/krohei/linux/commit/adae44a671f47e94d6aa0fba8fb51b78d40c
> 505d
> 
> I will resend it to Greg together with all the other Type-C patches
> that are ready next week after v4.19-rc4 unless Greg has picked it
> himself before that.

Ok, thanks for the update. Saw your patch to tidy up file locations so was
anticipating the need for a rebase, but this will save me job. :)

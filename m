Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D86C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5051222412
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="ScU+7F9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5051222412
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeHJPRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:17:17 -0400
Received: from mail-eopbgr80138.outbound.protection.outlook.com ([40.107.8.138]:44880
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727381AbeHJPRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNfRqIK3tytefxeO4x9RKWPZ6994twmZ02iRiNZzEz8=;
 b=ScU+7F9LKuwyoDO/01resK073ZoQbCsFnXJvOVrEr2iO0v/0QsRBxrsHr3UibVYU39eiAXglwad9hOHBjMYGYmhdGVN58CmX713dtfK1bi+H8r7+9tnUj/oph4ZNGz3HX1KFjqefowkbIxfcDnefD+8ApwUjquO+m1llwN6ioHo=
Received: from [192.168.13.3] (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.21; Fri, 10 Aug
 2018 12:47:22 +0000
Subject: Re: [PATCH v7 3/3] drm/atmel-hlcdc: support bus-width (12/16/18/24)
 in endpoint nodes
To:     linux-kernel@vger.kernel.org
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
References: <20180804111439.7455-1-peda@axentia.se>
 <20180804111439.7455-4-peda@axentia.se>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <73d5efe8-4589-5a84-7660-c952f22387a1@axentia.se>
Date:   Fri, 10 Aug 2018 14:47:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180804111439.7455-4-peda@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0902CA0054.eurprd09.prod.outlook.com
 (2603:10a6:7:15::43) To AM5PR0201MB2452.eurprd02.prod.outlook.com
 (2603:10a6:203:35::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3757b2e1-aa3d-40fd-3eaf-08d5febf6b5e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:YaMtknO0p1tnoRpKgoRXVLYR7R0L99LojeiCe32g8WWD9YKrZJVqigA2h98nqItHtv0ihcwTaaBIBYD9YX4OBpd5Mp8Kkd/QWXzVtCFDb5CByGwYgCFcgq5i2PWQTHHvVcSNQB7/5A3VrbgI3HlcLpX7/GLQlKUQ1TwvYQ9qoLSvxsVHa61aoTOrIR1l+tRgtNph1mqizpYR9dpJgb/x45USlgFzVWUeY8ShzHyyf+dT0AUFrxjVaAUJ/eUMEQlz;25:zcX5g5aMQKS8T5nxm4ny1In0v5xSYuXTBIy5BLU81Y1/fMRqmBmELLFxs6kIXdaal8btlFJ5OopNT9KRI4tMl3k085oxtkVNFbX44VpWgN+k2t8EsJpy632uSfyKpjD5Y3jloLRxWOPKMIyYvysTzi9p8CduqYSz2aWtNcRFPq7cEZNK35iQSd5g4qifghwQ+OsdDAk5ZvpbKMLd+XFDwRqiVL048Dp5chrjyzjyeTHQrI99Bp57GH0bWHMew9JLyJqAfY9Ns/hgQL894nk1CAxPw8f9AWRfdVFoO4A+vz9V/MJNcMSBQrd3LY+vJCwaHL3ueSYR3dXlnON9YkN/1g==;31:rwrLWpoRnU2x3eadBzgzofk8utFb4kMwObe505spMyCrBCi4uJ0zaO63XVe5PfhR3Ohr8cqK8bjVwzlVrLHa50EI1+RXNwVyc3KDJYUsG613g2V4fH8WKnstsewa63QO/135Ml+eWPOkYwjQWQrdeTODRp26g70fEHEGJpKrko+BjnaxgdaOkCQTrsDiB+0IsGzRlK92QRi6+mEv7nUwbyvKKhNuh4bOisEWECHliIA=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <AM5PR0201MB24526A24DA21DD5D7CC11EBDBC240@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:9+iq0s42Gf4tF1bdgFOEby2qaCnyU7QRXoJ0An7J0Hv3rww4crkzyqLDq1ZmSjjHd4xDxgBtx+4alZe0onPi/hzsETGDGY5hup9iW06uU93VQxnxIUd5mJ5ZVonCKwJ30jy9MCHF9NOGkBgdpYvOp5a1SwZ8BTANIFmTWyz5/5Tv5kmOeW/IDRScRp9VbNp0dEN3U4O3cusp7rv+b9EnZoZd+x3TspPevceS9s2DTNGgYQkq343D/enxMbmnIuEqBB3NiHnuwSmTOxkdwKLrtg==
X-Forefront-PRVS: 07607ED19A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(366004)(396003)(39830400003)(136003)(199004)(189003)(58126008)(5024004)(8936002)(316002)(3260700006)(25786009)(97736004)(16576012)(47776003)(65956001)(65806001)(54906003)(66066001)(117156002)(50466002)(26005)(386003)(77096007)(53546011)(478600001)(36756003)(229853002)(105586002)(6246003)(16526019)(11346002)(186003)(3846002)(6116002)(53936002)(486006)(476003)(956004)(2616005)(106356001)(4326008)(446003)(23676004)(36916002)(52116002)(230700001)(6916009)(65826007)(76176011)(52146003)(2486003)(6486002)(2351001)(5660300001)(68736007)(7416002)(31686004)(74482002)(81166006)(6666003)(64126003)(2361001)(31696002)(81156014)(2906002)(86362001)(7736002)(8676002)(575784001)(305945005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjAyMDFNQjI0NTI7MjM6R1BRV2haQVdObm1KTVhOQTYvbWtpMnlJ?=
 =?utf-8?B?eG1Lc3BaSnQyMWU4RHlpcDhVSjBMWElpYzBYS0JidFJ2bER3QjJ2R3dDWHJI?=
 =?utf-8?B?YWxFdUlYV0d4Zi9DMVBIajZ1b3FHYXhlN1hxOXYvVjE5SUNhYXpBcVpTL0RB?=
 =?utf-8?B?d3gzcFVsMVoyOTZBWVdtTDcrekdrR2xkaEh4UnM0RklNcHUreVVteWUxZVl2?=
 =?utf-8?B?Y3VGcjBuai9na2o0alJjMDd1eXdhUjZxWE1yczJkOVNnUDB3SHdpN2wxS0pG?=
 =?utf-8?B?WSt0M21ZUnVoa0VqNEY5ZFJTRGp0ZGw2WUdxMzZiTFkvWEZpOE9yV24zZWFi?=
 =?utf-8?B?SVpLaU1HQmJZT3JvNmlObTlhZkNvU1Q0SHN1WlhPT0s4UnZDd2trdngrK0Er?=
 =?utf-8?B?T0EvZkdNL3QrTjA5YXhZa1ZBa0RVL05wRno3ZjQrYnlVa0ZzNkt3K2IxMlQ5?=
 =?utf-8?B?MmluQlQrTTM0cTBZaUEweEZHaHM3aGozL0wxcWo5Zjg3NTdudllBaE9tVWxj?=
 =?utf-8?B?aGZTSlZBZTNrTzg5eDZYck1SV0FlQWR3UExja2QvMWVpOCs4S1krKzRGSjgv?=
 =?utf-8?B?VVlmZjkwUWZDb1IvclVOd2JYUFR2dlRQMWZHSmZESVcvNkRqdGpIRGVObzk3?=
 =?utf-8?B?ZVpyaFlRczV0dmZBUEE3YkJuL0VjM284SzhRUEtFY0VVeGsrbFJWT1dRRGpR?=
 =?utf-8?B?YXFKZlRXMlcvSExnN3B2dVVPUUJBZWp0SUlYMzdtMjE1ZjVUM2FXRU5saDZk?=
 =?utf-8?B?L2FqUEtLSEdsSVhIYnM3TDFQZjRYYjlLdFhsVmhHakNsbkpnWFJhK0s1L1l5?=
 =?utf-8?B?MWFVM0k3anQ4WFRJZnU1QUdDK3JOTExUR2ZrL0ZoSnZ2NDVpNG9nT1BRUk9B?=
 =?utf-8?B?UFBscHlydmVTNk44RWh3UklXd0t5ODhkdXZCaVk0YnhYOUsvMStEWEFzUWJm?=
 =?utf-8?B?b3dtRFE0NTgwcHNYZW0zYStsMDVDU1B6SjdYZFArbFpibkJieGcwOEVlOFpQ?=
 =?utf-8?B?UXVEWXV2OXJNbDV1NmtCVDVCaUxRWHBZYmdQQTZYeGVBN0s1elhGT3BCbjZh?=
 =?utf-8?B?VThHM3V0S1Vpb2VpanhlUERtOVlOek9JUndLUkg1SFB6a3dXRDhjUlJzYjIv?=
 =?utf-8?B?Mjl3dVFsd01vdzFqOEpiN0VrbUl2aEtxWFlVbVpkZ0RLaGJkTjRZNDM2T0pY?=
 =?utf-8?B?TmZMY0F4dzBVN2xwWVdtcExvTTZoZW1UelFjZzRDVnFSMk55WHhRM25VZXZI?=
 =?utf-8?B?SjlPUlZacEw1SXRLUGlCbzIrWDQ1V1Rlc3R2R2lZN1RyNTQ4REQxcWxJZ09E?=
 =?utf-8?B?OHZRTDZ2b0FxSEdkQkVubkVGcklCbkYwdDFoWEJvQ1FuNlRVSE5jUVdtTTFk?=
 =?utf-8?B?dzJXYUtwZ1RLZHV0K2lrNTRzYytmaGM3cXhUd3ZlSFZTcTlMTHZodVpDZm5O?=
 =?utf-8?B?eGYzcFpmQytWTFgweVArdDNiMSs1Q2xCeGFHZnpWWUZrbkUxV0xwL0JGL0tY?=
 =?utf-8?B?ZFBJS2dGOFZZVUxhTlBRQXlxRFA5VzNPdDlUdlpBeFgvQUJ2b1hnYXgrVTha?=
 =?utf-8?B?cFBlK2hGeGRRbzlrUWlySGp1ZkxzV0NoL0g5dlBrN0U2NXhSc3FjMndhcnlZ?=
 =?utf-8?B?Vkxjd1JlOUR1c3VQZnpJeGRLTkgwQlY1MVAwMWdISXc3Ynh4UjdZcjFIK243?=
 =?utf-8?B?RTAwaHZqUC9yTGdWUjFJMGwweWduWGNSQjc4VndKOTByMUlvazdnWEdMN1hs?=
 =?utf-8?B?NmVXMFdxVmk1RW9IU0hkUUIyWEcvelhUQTBxdzFQMnVmVkxtMUZlSlNxN0gw?=
 =?utf-8?B?OFNOYkNTK0RFU1J6c2R1ODhjbzZ5TUk0NWZ5VmlaUGxNalNNWW1zaG00bWxa?=
 =?utf-8?B?M3p1Qkk0UGIrNWtNS3AvNnJxTVZCVnpMdkpQR0FKZURlYlVlUDVXVkF2aXNa?=
 =?utf-8?B?b3VNdDgyOVlDZ2lQak9kMVkzeU5USzBOYUsrVlZvS2VzdjlJMXlJRHBCWTM0?=
 =?utf-8?B?WXBxTkJqdjQrVXp4bWNJTUVYNkdEOUdVMy81R2FOTGE2eHFCN0VmeUkrb1p5?=
 =?utf-8?B?MVRTZ1hmenFqTzhYMlUzeWJmbUk3NWF2OGZLWUpOZW53ZTRlRElsRVg5SHl2?=
 =?utf-8?B?Q1hvMGRxNmd1RXFSbzgxWjVHU0pLVUVKZHd2bzY1UFBrcGpPQWU2Y3B3Z1JV?=
 =?utf-8?Q?iD9YszJtZ3gl2OoOFsfrzIgEA3d1DNTmmDyt/rOCE64g=3D?=
X-Microsoft-Antispam-Message-Info: 3gKCVIQoMlTCCzg+c4Z7OqxAKvXpEagx/ODQRdqYcfJah73cnwve9NJBbGvchUctDVc52GNDOqiKBJ4BWuVDtg+sdD17T8usrxwLoZb9P8AH6bTXvWiS6RS63k/McYwYqRb3ABRXPWQx0Ub1OlXUPLpI6W1YnMNLyOkWg2CWFqgpN3WOMDBbpz5mGhnGxmeNqSWJYwz06w1V3d7T4ETaQ+nQc63uz4brm41zdUf20RjncVn4IV22/Bt7EgdjiVi44UQe4BhZ5yDFX+cucShzAAXBf+8DEiUZwMtVCci7ldPbDKJQDl8r4BbLG0KEDUivOBAlWmCBsNKCCjy5gW10hnx1RKsdgaVs/ZrCV/hgB9M=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:d+ebUie7ff7u8DMBMOXpUDkhh6j+1W46cr1whWoKAoINZt1qRQbWQcOz+zARV6jZEus1q+ZoL0TDvIb7Jt8jFfTZ4iiRyUwcg8Uj2TGw7FroJYwL1GB+IkSPOlVgLZq4QqkyA7iI/R7kNCBl2X0VsbJblN5w7worSvMcz4UlfzyS7zmWwk7bI0kKm0+db02mkYisbJbiQfDzuVnZd1A8uFWIOJHrAXfXMGcLG5b2V2deGrr41QdzR0doNi9fn/kUx/GvpOzxdNInT/Wl5y/uot5mNuu+t73ApJdCGdMn2ERRppKexv99cF0l2PfQo7/97r7FrZ0CaDRuQZhW6OzVCKPzBHY+LnjCw5BMd/2mXnZ+58UgIh/H92wrv14bo/Bxjv6mLWVS7AiaEcKNPBOe2KRGuaVmN+dDBLTtVaqWlXbEeE3fEyAyyHpnjbRsqVrLWCYYYS2fY1hzoJHDBd+JsQ==;5:PyWKCSNjaacFKm9BKvb3VlWvoL3YNvjB9z82aCWFwqYQLdjy1CwyxpQ9WAbQUChoE3bKYOkKoQoCJP6YhSBSA7I6CMArod28tooiSYcDuJiiU5gJECUNB+uwaTcLrXir/h1SOTB5D7zpt9kcxkiO6S6Pf71SdGlw5bTQdS2bF1U=;7:MZXycO4juZc12qy05wPgL+P0Nm72ISWyXpWqIpfOpj94jHQfHeIUNLq4wjwQGFnHR/l4KT2b5qZjHJPeY7/sSZo4hKTHrg8uz4hm48OE/AkH7q/vw72/ADz+gJiF1yDxxNSm0OTYScl0eoX7uIawBDuTHc9FANQSTJtt8DMs8wub8NpQ/QIA8VbgHsf3DZJYF5o6rZeFxWl1dzHpXlETRo9CvG1ibX50U2b7Bze/ITr8nHbpcDRWbrM4rCg60r5w
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 12:47:22.6342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3757b2e1-aa3d-40fd-3eaf-08d5febf6b5e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-04 13:14, Peter Rosin wrote:
> This beats the heuristic that the connector is involved in what format
> should be output for cases where this fails.

Sorry to reply to self, but...

> E.g. if there is a bridge that changes format between the encoder and the
> connector, or if some of the RGB pins between the lcd controller and the
> encoder are not routed on the PCB.
> 
> This is critical for the devices that have the "conflicting output
> formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
> RGB bits move around depending on the selected output mode. For
> devices that do not have the "conflicting output formats" issue
> (SAMA5D2, SAMA5D4), this is completely irrelevant.
> 
> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c   | 70 +++++++++++++++++-------
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     |  1 +
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 70 +++++++++++++++++++++---
>  3 files changed, 114 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index d73281095fac..c38a479ada98 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -226,6 +226,55 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
>  #define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
>  #define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
>  
> +static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
> +{
> +	struct drm_connector *connector = state->connector;
> +	struct drm_display_info *info = &connector->display_info;
> +	struct drm_encoder *encoder;
> +	unsigned int supported_fmts = 0;
> +	int j;
> +
> +	encoder = state->best_encoder;
> +	if (!encoder)
> +		encoder = connector->encoder;
> +
> +	switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
> +	case 0:
> +		break;
> +	case MEDIA_BUS_FMT_RGB444_1X12:
> +		return ATMEL_HLCDC_RGB444_OUTPUT;
> +	case MEDIA_BUS_FMT_RGB565_1X16:
> +		return ATMEL_HLCDC_RGB565_OUTPUT;
> +	case MEDIA_BUS_FMT_RGB666_1X18:
> +		return ATMEL_HLCDC_RGB666_OUTPUT;
> +	case MEDIA_BUS_FMT_RGB888_1X24:
> +		return ATMEL_HLCDC_RGB888_OUTPUT;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	for (j = 0; j < info->num_bus_formats; j++) {
> +		switch (info->bus_formats[j]) {
> +		case MEDIA_BUS_FMT_RGB444_1X12:
> +			supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
> +			break;
> +		case MEDIA_BUS_FMT_RGB565_1X16:
> +			supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
> +			break;
> +		case MEDIA_BUS_FMT_RGB666_1X18:
> +			supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
> +			break;
> +		case MEDIA_BUS_FMT_RGB888_1X24:
> +			supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return supported_fmts;
> +}
> +
>  static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
>  {
>  	unsigned int output_fmts = ATMEL_HLCDC_OUTPUT_MODE_MASK;
> @@ -238,31 +287,12 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
>  	crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
>  
>  	for_each_new_connector_in_state(state->state, connector, cstate, i) {
> -		struct drm_display_info *info = &connector->display_info;
>  		unsigned int supported_fmts = 0;
> -		int j;
>  
>  		if (!cstate->crtc)
>  			continue;
>  
> -		for (j = 0; j < info->num_bus_formats; j++) {
> -			switch (info->bus_formats[j]) {
> -			case MEDIA_BUS_FMT_RGB444_1X12:
> -				supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
> -				break;
> -			case MEDIA_BUS_FMT_RGB565_1X16:
> -				supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
> -				break;
> -			case MEDIA_BUS_FMT_RGB666_1X18:
> -				supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
> -				break;
> -			case MEDIA_BUS_FMT_RGB888_1X24:
> -				supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
> -				break;
> -			default:
> -				break;
> -			}
> -		}
> +		supported_fmts = atmel_hlcdc_connector_output_mode(cstate);
>  
>  		if (crtc->dc->desc->conflicting_output_formats)
>  			output_fmts &= supported_fmts;
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> index 60c937f42114..4cc1e03f0aee 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> @@ -441,5 +441,6 @@ void atmel_hlcdc_crtc_irq(struct drm_crtc *c);
>  int atmel_hlcdc_crtc_create(struct drm_device *dev);
>  
>  int atmel_hlcdc_create_outputs(struct drm_device *dev);
> +int atmel_hlcdc_encoder_get_bus_fmt(struct drm_encoder *encoder);
>  
>  #endif /* DRM_ATMEL_HLCDC_H */
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> index 8db51fb131db..f587ae596791 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> @@ -27,33 +27,89 @@
>  
>  #include "atmel_hlcdc_dc.h"
>  
> +struct atmel_hlcdc_rgb_output {
> +	struct drm_encoder encoder;
> +	int bus_fmt;
> +};
> +
>  static const struct drm_encoder_funcs atmel_hlcdc_panel_encoder_funcs = {
>  	.destroy = drm_encoder_cleanup,
>  };
>  
> +static struct atmel_hlcdc_rgb_output *
> +atmel_hlcdc_encoder_to_rgb_output(struct drm_encoder *encoder)
> +{
> +	return container_of(encoder, struct atmel_hlcdc_rgb_output, encoder);
> +}
> +
> +int atmel_hlcdc_encoder_get_bus_fmt(struct drm_encoder *encoder)
> +{
> +	struct atmel_hlcdc_rgb_output *output;
> +
> +	output = atmel_hlcdc_encoder_to_rgb_output(encoder);
> +
> +	return output->bus_fmt;
> +}
> +
> +static int atmel_hlcdc_of_bus_fmt(struct device_node *ep)
> +{
> +	u32 bus_width;
> +	int ret;
> +
> +	ret = of_property_read_u32(ep, "bus-width", &bus_width);
> +	if (ret == -EINVAL)
> +		return 0;
> +	if (ret)
> +		return ret;
> +
> +	switch (bus_width) {
> +	case 12:
> +		return MEDIA_BUS_FMT_RGB444_1X12;
> +	case 16:
> +		return MEDIA_BUS_FMT_RGB565_1X16;
> +	case 18:
> +		return MEDIA_BUS_FMT_RGB666_1X18;
> +	case 24:
> +		return MEDIA_BUS_FMT_RGB888_1X24;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>  {
> -	struct drm_encoder *encoder;
> +	struct atmel_hlcdc_rgb_output *output;
> +	struct device_node *ep;
>  	struct drm_panel *panel;
>  	struct drm_bridge *bridge;
>  	int ret;
>  
> +	ep = of_graph_get_endpoint_by_regs(dev->dev->of_node, 0, endpoint);


...I just noticed that the ep device_node is never put away...

> +	if (!ep)
> +		return -ENODEV;
> +
>  	ret = drm_of_find_panel_or_bridge(dev->dev->of_node, 0, endpoint,
>  					  &panel, &bridge);
>  	if (ret)
>  		return ret;
>  
> -	encoder = devm_kzalloc(dev->dev, sizeof(*encoder), GFP_KERNEL);
> -	if (!encoder)
> +	output = devm_kzalloc(dev->dev, sizeof(*output), GFP_KERNEL);
> +	if (!output)
>  		return -EINVAL;

...and this should be -ENOMEM. Not that this latter buglet is a problem
with this series, but since I noticed it and am going to resend anyway
I'm going to fix that too.

Cheers,
Peter

>  
> -	ret = drm_encoder_init(dev, encoder,
> +	output->bus_fmt = atmel_hlcdc_of_bus_fmt(ep);
> +	if (output->bus_fmt < 0) {
> +		dev_err(dev->dev, "invalid bus width\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = drm_encoder_init(dev, &output->encoder,
>  			       &atmel_hlcdc_panel_encoder_funcs,
>  			       DRM_MODE_ENCODER_NONE, NULL);
>  	if (ret)
>  		return ret;
>  
> -	encoder->possible_crtcs = 0x1;
> +	output->encoder.possible_crtcs = 0x1;
>  
>  	if (panel) {
>  		bridge = drm_panel_bridge_add(panel, DRM_MODE_CONNECTOR_Unknown);
> @@ -62,7 +118,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>  	}
>  
>  	if (bridge) {
> -		ret = drm_bridge_attach(encoder, bridge, NULL);
> +		ret = drm_bridge_attach(&output->encoder, bridge, NULL);
>  		if (!ret)
>  			return 0;
>  
> @@ -70,7 +126,7 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>  			drm_panel_bridge_remove(bridge);
>  	}
>  
> -	drm_encoder_cleanup(encoder);
> +	drm_encoder_cleanup(&output->encoder);
>  
>  	return ret;
>  }
> 


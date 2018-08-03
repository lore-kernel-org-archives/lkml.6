Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBFFC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577DA2176D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="g3d6xvLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577DA2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbeHCROk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 13:14:40 -0400
Received: from mail-he1eur01on0138.outbound.protection.outlook.com ([104.47.0.138]:64384
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732219AbeHCROj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 13:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqeCgjsGTOc6u4iSeKDRL6ld0ymig+POc65tZzTZcIc=;
 b=g3d6xvLFD1PFoDv5DkuIriklp8lf/H58evgz7PbNsVYJKJLHwOIg1M4+YNVV2w///2duZPYctduvcstzs3d/3zWyskdIeMdFtkgvT6RXviuABV+XkNlyv5WelLTrysza60nnnuy5RKz+jqONZcSwDZaxvJ6Wxz6Mjpt/L5jseGk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 AM5PR0201MB2449.eurprd02.prod.outlook.com (2603:10a6:203:34::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.21; Fri, 3 Aug
 2018 15:17:46 +0000
Subject: Re: [PATCH v6 2/3] dt-bindings: display: atmel: optional
 video-interface of endpoints
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
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
        Jacopo Mondi <jacopo+renesas@jmondi.org>
References: <20180803101124.4622-1-peda@axentia.se>
 <20180803101124.4622-3-peda@axentia.se>
 <20180803103225.xkwqe3wiv2gwdo5g@valkosipuli.retiisi.org.uk>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <edf0e474-409f-c7cf-97c4-5175cdebbaee@axentia.se>
Date:   Fri, 3 Aug 2018 17:17:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180803103225.xkwqe3wiv2gwdo5g@valkosipuli.retiisi.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0202CA0017.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::27) To AM5PR0201MB2449.eurprd02.prod.outlook.com
 (2603:10a6:203:34::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b70ad0f-8840-4f50-21ac-08d5f954452c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;3:kM9YSZ4grlvYq0p9G3znpsF/UBLuKHNEwNSpCmuArpG0eG1DXDfn2D12rwsKI42Toon5EmnqZ0mAiFqVue0BPm1zxijmqY73+I7jtt7469o86w+TL+VUghOsyMUVz7gZO9ICl39jGcOUpqqL43FrAlcM45O0kY5AFTeKIT1LOwvjQpg1zG5jo3vbbvbSBHJqUbDHt88inSHrGM5i5iMVnYfJZdVWCP6d99KD3+sqCA/yxfETNtWJODIMv4PGiN4S;25:i5St9uR4iJfs7qTXVaV6u+aP31z55UWKCdNnxlx+G+OIFHlWd0RavDwdBJQuZjCfIR7SkfGx3aO9GXxVGHGlC38/Bv6JmzaldzHFi3z2bCA7D+xtlk4umkd2/EUorIFRfCp+VQ3wtrry5xAOGbi8Zpq1UwhN61TFq7GMjbn1EmeXS6Y3CoWJbknWJFG0NU6sPF3JHjGKC9bhaUfHnf0RvO0SRt1Mq+PaUDdtHP/UcY+QFwTDtiqxzdPezIzHoE2GcVcmkNjVtMZvxFynT7cSzeq0p57WEvGpOfetfYtJ/YC+00O28J0ziNF5K12tsw2FU82Q+hQngoY+MXlD8qbRgA==;31:tCUBWjvky3+Vo/S4HliED2CZbL7I+TQ4mctiDOmJd8/nzRvuAfmEWwlC/u54AkxyFlFHglcGtV5Z77eInWyphusy3FMLz1Mdlf6tRSEz6JLCNapexI5pPqO+PgPepfsy+9WN+Pj/MHHFKFzMDKv/znzskgMqbLcuyta7XCcAlqUKZSRpjWzFWZLNaXjpfu4hPZqoVks+/0qQ4qpnNxnFmEHUeFXhHKKjWiVBJoPfmJw=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2449:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2449FC97DC5C16EEFABDEAC9BC230@AM5PR0201MB2449.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011)(7699016);SRVR:AM5PR0201MB2449;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;4:brJSpV5Fo1HgIzc79lnef1F6XQ2b4uV6td6ixVpo56fGS02lKSR7AggZXtRfay7VrS1s8lsnMRPYiZYbnOzLDvCP00OcprtMuQg+IJQiZiucCZrEiBRte8A+nXkC+AHgSeiFX+E+3fq3/fmB/odx6QTLI8EY+nJBsFtmz2BIfCb/wtrd5RbfQpPhSMVgGeLzqx7pRv0aoDAkzDe4aAkJev1pz1Bj692K/W2cxlEh5lzBNv0QpbjEUgBDjzRHhfZxOEtAQQRYoeIVTka9NwyGvA==
X-Forefront-PRVS: 0753EA505A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(136003)(376002)(346002)(396003)(39840400004)(189003)(199004)(316002)(5660300001)(229853002)(54906003)(26005)(36916002)(36756003)(7736002)(6486002)(31686004)(81166006)(25786009)(3260700006)(117156002)(81156014)(7416002)(2906002)(74482002)(6916009)(58126008)(106356001)(305945005)(8676002)(97736004)(65826007)(6666003)(16576012)(68736007)(8936002)(47776003)(31696002)(4326008)(2616005)(3846002)(6246003)(23676004)(14444005)(52146003)(230700001)(2486003)(11346002)(6306002)(476003)(446003)(76176011)(16526019)(956004)(64126003)(65806001)(77096007)(105586002)(386003)(65956001)(66066001)(186003)(486006)(478600001)(53936002)(86362001)(50466002)(6116002)(52116002)(53546011)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2449;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjAyMDFNQjI0NDk7MjM6NVZXeEtaZmhUOUdGYUEzQlBnd2NpYmk0?=
 =?utf-8?B?RXp1YTNjRFlCOTVaS3lOYjBiUGUzMXV1SlZjbHZqRCtoTTJ2elJ4bEUvKzBD?=
 =?utf-8?B?bEc5RTU3MVdwbFJaczRRa1Y2dHR4THdUQmtkcml4U1djc1lNZWNON20ybWZo?=
 =?utf-8?B?L0JEdXNyTTQ3SXY2cXFHbkg2dFF2dUViNnpsQVpVSTRqYlpvZlp6SmZGaU1v?=
 =?utf-8?B?N0lJQ0tUYTVnSXhrV0tXajhOa25KTER2RmRFNkNuRXd5QTVvdHgrdXp4cVpZ?=
 =?utf-8?B?eFdBUmxMUzFYbFJoQlgvVnRLdDdiQ2pPdFR1QXRXZEdtNWN2bjg5Y05FVGo3?=
 =?utf-8?B?RldlMVl5WHJCVmdUTmFaelBxMGcrRkc1NGlzK1R2bXExbGw1aXJ5blBMZU9p?=
 =?utf-8?B?RnVUdUdzK2NneUFWdnp3YWhsZmFaSTVpQkdBc0EwVUczS1kvd0JUOHhCSXBS?=
 =?utf-8?B?ZDRuVHJJSno4Uk44ZWpjYUx6bW1GSjY3NWIwNzBxdHlQTzBBRGVhYytMT29i?=
 =?utf-8?B?TmQ1T0tXNzZYTE4xOXp6TFoyaTA4WUx0THdlMU5mSkNoR3hlblZzNzJiaVN6?=
 =?utf-8?B?cWpsYjB0RjZGMlhmOHloNUI0c2RnWmtwNGgxZGNJQ3pDMVlGUGMzQzh6cGRv?=
 =?utf-8?B?WjlRdGhDakllK3BTOWNOM1FBSTVveDNtbStCWWRYRjhNa0JGWmtzbkNtbW1Z?=
 =?utf-8?B?ci9KOGIwRkxRc3V3YUJRN01SdHBsWmhaalNDMnNHZWVPVUJ4TjNyUDlVaXdk?=
 =?utf-8?B?UjBIYnpOUEEwOS9pV2RXUTdHYzhFbi9XckNySkZnQXhmV3F5NGw3YVQ5TW5q?=
 =?utf-8?B?c2xpdVNRZXcyM201SVcrSFJnaGNYbVpGSTlsUmFPNnFVR2ZyTk85ZlFYYUFI?=
 =?utf-8?B?dWtsUU9RUXVVTU1SNlFXOWNoRmFMbVNWaHhmT1VlSTdYN1lWeUJFbGtkQ3lt?=
 =?utf-8?B?RnNva2V5dFVveHpOUVRSL1BZbFd6MjR2aFp2ZFRVQnl3SVBlSUZaQUh6MEF1?=
 =?utf-8?B?K3NQWG5PZFpFTktBQmw0bmNHZmIreHEzaWxSbG9LL20xbjVsTWtyODhYZVo2?=
 =?utf-8?B?WC8wU1FMZUZrSy8wNmMrWkE3bFJNeDZRQlRkc3lZNGh6RC9HYlJONWxWQjJh?=
 =?utf-8?B?aDN2OTJMMUpoZFVzZ1k1Uit1eDVHWE5rZktWRUtPVlBJc3kwSzVGQkh5Skp6?=
 =?utf-8?B?WTEzTXZOMnJrRHZvSXdxT1VacG1kM05QSS9YcjNndkkvYUpTRFN1NDJHdnpF?=
 =?utf-8?B?d1JLTVRodTFDRWhCQmxtMXpGU3hNUDdGZzVEcmxnWHhWbWJMMWw3dkVlR3pB?=
 =?utf-8?B?cDgxSE5Cb3pBQkM2aGs2MEdSWmEyRDdLTnBMbG5HUGs4SUtIK2VqSms5bGtY?=
 =?utf-8?B?UlFuUXQxSzJpVy94cVNjR1lKQTZIVitmQTd2VmlFZG51TEZacFdBUHYzVFlu?=
 =?utf-8?B?S0xQWWxsWWlGT0tUNEV0UStPK1dneGt3TkgwQkFTekEyaS9XdGRFbWZUQzhr?=
 =?utf-8?B?L0dLaUd6NjB4M1lUbzdrWnppbWxDME8yb0lqQTYybk9EbmhDckFPNlVmdE9v?=
 =?utf-8?B?bFpkUWlEcW9RbFNHRkhkanB6Q2YrNVFjOWxMMEp3dWJUZkx1cnN6S3ZHbnU0?=
 =?utf-8?B?UDQwYlE4RUhQY2ppc08ydGJ5WEVycS8zT2dmOGJTazdZcVk5aHhtdHQyVFF4?=
 =?utf-8?B?Q1NncU5jbXFFZkE3TzZweC9WUDVtZk1SVmY3RUJNTHVmRmZKMTZzbUxhWVYy?=
 =?utf-8?B?M2tIYTh5TkwrUXNHaVZRam9xTlI5ZFhvMElpbGplTjFIdjI4bFRXZi9aYklx?=
 =?utf-8?B?MmdSbVFRNi92N09aNDQwbERzS3Q5L1k0MnpKcGtMN3kzMUhVZU14L3U0eUhv?=
 =?utf-8?B?dStCdzArV1ZXdzU0clo0RWk3cGZEVjFxd0g4bVpSRVdPZjhBM2tQdUxOT1V2?=
 =?utf-8?B?SXM0dFRxRlRHNnU4UmpoVk13eE5mOXQ5eGtOR2dCNkNNQWR4WHpySVdWdWJV?=
 =?utf-8?B?SGo2MitiWWprZkJYaWpsUU90amhSdVc0SVJzR3M0RTlFMkN4MXltdGhGa1Bu?=
 =?utf-8?B?V3RtaktzYjcvczRQSzdGV1JZTmxjVDMvOUlMcW1lc1dPbklsb0FhbFEvYlVy?=
 =?utf-8?Q?IX0m6zKH+RrQK0eI05oIwUNvs8rpduT3TlLhkHsRMbj+Gc?=
X-Microsoft-Antispam-Message-Info: 6BDA+WhZQs9GOldP+z14hxe5UKiKcMKQPNRCJnBCNQK1Rnq/eekkGnSCYer+Rvt6s0xsK47NF2UBucpQrxah1OhtcVUrbDk5LN3R+O1PpYiZaAMQ7VyHRWZQDCrsKaNsZ2Vm8TbJx/mRzjVmcegpBQBMzdwKtwK6bRJrffce9q4JUxuynJESWqrRNDqAcr4NzoyhYXcUo9R4IbXXEa1Z+CFSXUW5n2WtFJgf5EVgpwnUTuSSzI50tGkMGd3xVjFlLBjcdF+NZ69XyosAJUMOvfHj/tBhtxh/lSBfG8QE23l2ouSNxvmMRkjDRNl1uthIgJDEK41+Xug4WA9iP8DhWxUifcDLSDa8ai2/DvPunyw=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;6:8KmYCBNA7+mRBtWOMpOUpoSsBQkgtR+C1k+VygepfeX4diqGQzs3LaVmCZ0oRP9wfiLV30kCkoKDVq849oZZyaocEkMjjI5MERJbs2w7JUk7ix/RFigv/rYRFgjxHD9LSQZflLXicJMs8KeWJA/X3/5KbYw8T2+Zi7WoRDrch/ik8iRxZ+v97cUchiOYvP8tmRPFxzI3LXDl0I2sfSvG63ViF2aB+3pzhlKcyqwE0yQZg6F0gnvFnQBlr88v0276tb9f8GA6L3pbkv4HGv5C2TAGpMnXBV+bCE62oWiUYD6IC1E4EN6JWFfUgOsxCF4Pcca90zpiDE167D2c6/31mCvDur4613gP7avMwDjpA0BoG0xW1ffU3BI2hEw2E3+Huq3sXA6lZUYtv+bTrQolhYtjeU7U/4gPlaOXys1iKGx96hNGxnVb3fEp2/V1gTG/QW5ct8nhMER/pYQxIGNpYw==;5:T1sXeU+F7XUB55NVVCcOsqglyL1hkC0oVQU78q+TTkaMVrUgD4iPtM6efv3DCkcFFGY70XRQP2hBonseYFDTqW9vL/mUi2wF34afpBb5WwH+qrDPWRmemNyFXCiqwJmXX1PbG3+RFmTZNiyLPFtrrOvXCAI0JsPP/mSR0hfWOIU=;7:qjjyHlBEcnUIz1WIQTo+msTj5sCZzB9T8xhmkls1wtbrvSAqefk3/EVlpB49xfnyEFcplkRz4ZNBS5KA6LHvqVI6qM3Xr49arDccQvzL+FycW7tmWaFAnvPoyHbUPVEBRTWWSCir+Ajtguvo+YTDm0/hE21AncZ5LuoUfITeq62zjbWeoXu92xd0wt1aMOWA5oVbU8ueDEUimYB9xE2eBN6v8s1fuN2fKgclAvPSwgwZhTa3HN7+A/9+ejS4MZxo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 15:17:46.5452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b70ad0f-8840-4f50-21ac-08d5f954452c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-03 12:32, Sakari Ailus wrote:
> Hi Peter,
> 
> Thanks for cc'ing me.

You're welcome, but Laurent is the one to "blame" for hooking you
up... :-)

> On Fri, Aug 03, 2018 at 12:11:23PM +0200, Peter Rosin wrote:
>> With bus-type/bus-width properties in the endpoint nodes, the video-
>> interface of the connection can be specified for cases where the
>> heuristic fails to select the correct output mode. This can happen
>> e.g. if not all RGB pins are routed on the PCB; the driver has no
>> way of knowing this, and needs to be told explicitly.
>>
>> This is critical for the devices that have the "conflicting output
>> formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
>> RGB bits move around depending on the selected output mode. For
>> devices that do not have the "conflicting output formats" issue
>> (SAMA5D2, SAMA5D4), this is completely irrelevant.
>>
>> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 30 ++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>> index 82f2acb3d374..10e8707d1443 100644
>> --- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>> +++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>> @@ -15,6 +15,14 @@ Required children nodes:
>>   to external devices using the OF graph reprensentation (see ../graph.txt).
>>   At least one port node is required.
>>  
>> +Optional properties in grandchild nodes:
>> + Any endpoint grandchild node may specify a desired video interface
>> + according to ../../media/video-interfaces.txt, specifically
>> + - bus-type: must be <0>.
> 
> bus-type won't tell anything in this case, you could simply drop it. If
> your hardware only supports parallel or Bt.656 bus then the code parsing
> the properties can (and should) know the bus type as well.
> 
> Looking at your implementation, bus-type is not being used. This supports
> the suggestion.

I only added the "bus-type = <0>;" in order to disallow any other
value for the bus-type to make it clear that any non-zero value would
be a bug in the device-tree and not in the driver...

> The V4L2 implementation is about to change as well and there's a bit of
> discussion ongoing related to the bus-type property:
> 
> <URL:https://www.spinics.net/lists/linux-media/msg137980.html>
> <URL:https://www.spinics.net/lists/linux-media/msg137979.html>

...but I can certainly drop "bus-type = <0>;" from the binding if it
is going away anyway. However, I wonder why it's ok to silently drop
the autodetect meaning of zero? What about old device-trees that do
have that zero there? Are those suddenly not conforming? Wouldn't a
deprecation notice be better so that old existing device-trees can
be parsed/understood even when using modern bindings documentation?

Cheers,
Peter

> 
>> + - bus-width: recognized values are <12>, <16>, <18> and <24>, and
>> +   override any output mode selection heuristic, forcing "rgb444",
>> +   "rgb565", "rgb666" and "rgb888" respectively.
>> +
>>  Example:
>>  
>>  	hlcdc: hlcdc@f0030000 {
>> @@ -50,3 +58,25 @@ Example:
>>  			#pwm-cells = <3>;
>>  		};
>>  	};
>> +
>> +Example 2: With a video interface override to force rgb565; as above
>> +but with these changes/additions:
>> +
>> +	&hlcdc {
>> +		hlcdc-display-controller {
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
>> +
>> +			port@0 {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				reg = <0>;
>> +
>> +				hlcdc_panel_output: endpoint@0 {
>> +					reg = <0>;
>> +					bus-type = <0>;
>> +					bus-width = <16>;
>> +				};
>> +			};
>> +		};
>> +	};
> 


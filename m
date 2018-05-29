Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967296AbeE2ViE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:38:04 -0400
Received: from mail-db5eur01on0106.outbound.protection.outlook.com ([104.47.2.106]:60032
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966949AbeE2ViB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:38:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
To: Boris Brezillon <boris.brezillon@bootlin.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
References: <20180329131054.22506-1-peda@axentia.se>
 <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
 <20180402142249.7e076a64@bbrezillon>
 <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
 <20180402212843.164d5d21@bbrezillon> <20180402222020.1d344c14@bbrezillon>
 <d7e6f78d-b57b-4d0f-c07c-ca6c1930cd51@axentia.se>
 <20180403091813.5fb5c18c@bbrezillon>
 <d0afd431-6e51-a9b7-c103-ecf1f6e07c2e@axentia.se>
 <959d826d-1a98-ca22-acee-a4548427fcd3@microchip.com>
 <a25ca617-d3da-d401-1ba9-8e5887f8a8e5@microchip.com>
 <024079cb-77ad-9c48-e370-e6e8f2de171b@axentia.se>
 <9c496531-f7b6-4b9d-dd51-0bfb68ead303@axentia.se>
 <c3cc1894-2d7d-93b6-a9de-ed9ca4564ae9@axentia.se>
 <19d68279-072e-7646-6fdd-8649578229ea@microchip.com>
 <20180529164911.29820e07@bbrezillon>
 <e3c34fb7-4881-3f49-b43b-1b07a8ab865d@microchip.com>
 <20180529171555.19dd723f@bbrezillon>
 <1affd186-7f78-8bb0-050e-da82143c2982@microchip.com>
 <20180529174621.50a9001a@bbrezillon> <20180529195708.1fa41027@bbrezillon>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <6d59f0b7-1213-f225-3e58-8326d384a1d8@axentia.se>
Date: Tue, 29 May 2018 23:37:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529195708.1fa41027@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P189CA0021.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::34)
 To VI1PR0201MB2463.eurprd02.prod.outlook.com (2603:10a6:800:54::23)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2463;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;3:BqAmWLsjRgruiMd8wVXaZmmNqmKEV3hG2PLjS76HXcpltDL/0Lc9rH3FUlaimi7KEOH2hQ/EV5Iexe+oIg32MTLXPNQRss0JQPasRhp5F2trLGyXlcmBIN+UQdRR9vVM6U5+k6kTwNgkGOW+h4/uowjTyr/DnyStM/vhO47BcW2AhQ67HX6hplIra7i8NK3GFRfArOYHsySMleZ05rjSCTDc/wsDC8O+k0EKF7qt6+GFXv1Kido9Eve/wtDRMSMO;25:FdWjw4SU/jA/zvX2CjFLiVW01YpAmjrLLTl/g6jfCOeBJyEzxwk8yilKOB5jBKpbnYRP/5TpScVW1zdStYRGDaTTeRG/O5/0La8XwspUIChatfftUK3I/qJQdjj3qQYVuXfB/2Wv4HURM3jWJOFLGkTFbaefEND4yxL6FAchhEIRe0G5JLBkS7JT16tpwweIG7YOqfM2T9r/V7CT87sd8pvsmao9k/xpruNgzlJq+2sT5OePQU9GI6LN5jK2YiPMgbWYw3oKFCfkLn6asvXMFSVU72+bvZselWmwEK7VI9KD8W14u3wzA+23J0ztCv71PgxdcizR8GboqdT0Dyt94w==;31:DIZzhZrbOU41+XphA1BhUNO2UGdrPDe9WlyY9d1fD4B4kKHLs22gAqnr/vImSvCYgPiKreCLwj/9FUNumO9q+zfPRT1PVcJ3rSaRaEgWJbC31+Zi9uSKFnyv+JWpyapwCiZOcnOjcURIUVVjDxn3zDJ36Xv7jwwRfu4ry4Zp3AOIbRD/pH17BHxBOG0M6aZuZiJxzTm5m1NoIm3C0zzyLsZikxp4MENESu9/t45RVjQ=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2463:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2463B799D4148CF8834B67A7BC6D0@VI1PR0201MB2463.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2463;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2463;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;4:ETvAORrM3fMWzEQSJ7hTOfcY0TuMZBmNwr5Su3uBKWLXJr6ENyrGfScu/5AwAFrJ5/Tk8c4NZDzF0N4m6hZT+Mmp42FQxDT0w0LokTnpPEZl3jf2TBWsdp3Jhv80f9q3Y+AR4vPDqm2/L3NRzxbpLHyFbSU0isomDmL38X3g9P1iD1hDPKoJcEeags2CJ0v17KXcNCCsRQH5S7MW8D+MfkKPsP6djiqt+2GC1d6OYycmhjHFobOPvuceHyeSBsOQlf8sH9q0Hkq8EsCzgI769Q==
X-Forefront-PRVS: 0687389FB0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(346002)(376002)(396003)(39830400003)(366004)(52314003)(189003)(199004)(6246003)(64126003)(117156002)(53936002)(39060400002)(26005)(77096007)(31686004)(53546011)(186003)(31696002)(16526019)(86362001)(478600001)(97736004)(106356001)(50466002)(68736007)(6666003)(3260700006)(25786009)(8676002)(93886005)(8936002)(65826007)(47776003)(2906002)(81166006)(36756003)(7416002)(74482002)(316002)(66066001)(65956001)(81156014)(6486002)(230700001)(5660300001)(486006)(229853002)(36916002)(52146003)(2486003)(23676004)(65806001)(956004)(52116002)(4326008)(105586002)(2616005)(386003)(3846002)(76176011)(446003)(110136005)(11346002)(16576012)(58126008)(7736002)(54906003)(476003)(305945005)(6116002)(59450400001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2463;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjM7MjM6K2pRN2toSjE2dlJTS1h2eU1DRkdzUVBh?=
 =?utf-8?B?bEp2RWVVRWpBQVpDekRLR040THNXSGVKRjFkT0lPUDh6Zis1b0FhY2NLV09z?=
 =?utf-8?B?SXhrZnNlK1VNTEptbVBOdk8xVVVWQ3lTUjFjQVFYaXFUYVFTRzR1ZTR4VjZk?=
 =?utf-8?B?Q2dPcTVaTHdRcTM0YldTbTNURzNrZGZpQjMvR01UVDZHV05tdG53WHYvZHRD?=
 =?utf-8?B?dENJbXB1S0lQR3lkUHJnbkQ1THlYZWxPTjRzWXBuZWxJdUMvTkZWRnlFWmJt?=
 =?utf-8?B?NGV3TXJOeUtsMWI3bTdjUW13V3M2elI1QTJoYUhuVG9Dc0J2NVNTb1lCbzlC?=
 =?utf-8?B?QkFHM1VtVUF4NkxiUExyRGRyQ1VyQTF4RDhoVkpSUklaWWhjUmovQUJ4OXdi?=
 =?utf-8?B?VXdEdWp3cTZOb0dUTXl3MXloUXcyNEgwRzNVMXdkaHhmRXhGcEs0V1FJVXpl?=
 =?utf-8?B?aVYzdWVocnNpeU9pbTNUcm9iMlVPeGFsSWg3UmpTai9kekIzZ1RBUyt6N3hI?=
 =?utf-8?B?aDcwM1pOVGJkQXlYTW8wQXNUR0Jmc3pGUGdJc1lTdFZzeWQ4VU91QVlLMHB1?=
 =?utf-8?B?Q1htYlVJRkdjaC9uZzUvSGNORjh5WlJHMWFidzcxZENDdVVSK1o3ZlFBcGNY?=
 =?utf-8?B?cEhHenZIK0I5cVplN3pOc0dHWG5pMjFrRWJjck1wLzVmSFBsV1pWMEZMOUNF?=
 =?utf-8?B?Z3AxT29Rc2tWZWk4MExFbE4yaTl0VXNjSlRWczhUN0dMU0RJdWV1TjVVRUJa?=
 =?utf-8?B?Q3R3bko4N2U0dDRHeTM4UzVLQ0Q0LzM3aU5rdzNmS3hNSXE2V2p6eGNHUjNS?=
 =?utf-8?B?a0ZnVHhwK2FWV05XK1p2dU5Xb01YNEEybzBJemliQW1sN1QwaHlRbTVOSXdU?=
 =?utf-8?B?anIvcHdCNkVpK0JOdEpCTVliNnp6eXhYTHhOWDFpZFdZeHdKMVozZVRJYUtr?=
 =?utf-8?B?NU5sb3hXVUxCcmtJQ2dhcUJ2QThMbExhZ1hCNDBDd3g0M3ZyWVoxakoyeW9R?=
 =?utf-8?B?OW0wMVVoNDFNV2dyMGVLL29Kd250TXUrYWJKYmVlNktJYVJ0ZWw2THErV2Z4?=
 =?utf-8?B?bWVFOEl5YWNlL3V2MkozcjQ1ZXlrdzltdC9jc1NlSlZ5azVNMzJwcmU5d3NK?=
 =?utf-8?B?aE1pa1F3eWR0aE4vTDFRR1Vmc1Z4RXJzeXJ1Tktiek1qQ21YdytUTm1zb0Ny?=
 =?utf-8?B?eDVCZ1MyM3pXalFNL3NDandLZ0ZBMlQyUVhwbmk2eEg2cHBRYWRxcVRmVXhZ?=
 =?utf-8?B?RjZyNGY1eHE3cHpJMEdwS3RsaEdiVUY4WFQrdVJxTEVNdVc2cFhkbGtyN1BN?=
 =?utf-8?B?WVdHVHlRaGlxNkJ3YnhBelBvY3p0K2NuWWVOb1ZLN000bWJMLzE1QkhwbjBr?=
 =?utf-8?B?MUY0UUcyTDhZMTY3VG15emY4dnlNRW1MWFQ5bVc0eXNzOHFIUUJwY3VQUlZa?=
 =?utf-8?B?MEJuWW9QZEVLRFNKdVA3NmdLSVlBMktsZDJVU3Flano5aXdEQmJNd0VaR3Er?=
 =?utf-8?B?enFFd2dLbkloZ0NlK3h4L3Z4a3pkN0RtOHpOdDUvUU9ZT1hkZ2lac1ZPQ3FI?=
 =?utf-8?B?TCtYRUlYNVlydFFxck51bUp6L20wUW5LT3FIYW81VnJCM1pBUFEvOS95emRr?=
 =?utf-8?B?Q2J1TU85NjV3SUliWnNTNkhEZFBNMVdRVkcyUFZRRzR1cFVLeGRnUmhCUzdM?=
 =?utf-8?B?OEJSL3J3MVJBbGtOdTZFd0FkaE42RSswWHZWU2pVRkI2Zk02NnFZYlA4UXhY?=
 =?utf-8?B?WkdTZlhtVDQ0eU56SE85T0hhN2ttdERmck5sM3Z0LzNHQmlVbFlKYWUycHV2?=
 =?utf-8?B?N2JnMmFvNGJMUEp6SEtEVVFVcVp0aFhxT0hHUXd0d0dEZm5qa1hsQ1VQSm5J?=
 =?utf-8?B?eTFzaDhGQmNJNmtWNitHMjZGWGt3a053d3BaYmVEaFJpYmhsWTkyUGRwZVJV?=
 =?utf-8?B?M0hjS09ORTRyL1E2S1J3YkpLSTIxVjZ0V3Jqc0RrTloxYUNxQnFqa1BTdWFr?=
 =?utf-8?B?LzN6ZUdWVUFEbGh1VVIxQUt4dGlhamJzQXN2eU9SdmZpOEZIWGpOY1RWaGU4?=
 =?utf-8?B?dEx4akpiT1dwTmRNTXVIWTZ2VURmMGJ5ZTNpSVNNN1FTNURHZ3RNbHgveHVH?=
 =?utf-8?B?TDh1b0RFaGJkanZWc1d1VGxEdGhKc0J4NHFYTFNRaTVJMjdmNnM3QXVIeE9Y?=
 =?utf-8?B?VVRCZlJqOHVzUTF1SE56dFdoZjVxUDdGc2VRdTI0Ums5eXZUTktXQnUrMFhw?=
 =?utf-8?Q?jn2P1tTqZ8vX6WJ2naX0?=
X-Microsoft-Antispam-Message-Info: FSaepgPY4FHSdhqY55vhUCYeUziD9b3NNRbygZr9zWGo5hwptLZkD4gE6uOKrxxolOUYuks5RDJVYzLU3Zl6invKIIH3UoHX8CjO/NcUQn44sgDT6Xl9jXo4M67p24T0EbNLm9dWyYsoh4oQNjaga0YoJEdHHJhVrLzM2stt+LdQsVkcZ9ASIjYNp2s5XoSQ
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;6:qi3OxSUY7Nlh28b1KvTs6u38TK06gYpcq1QhX7CO6qsUbQZeAczAlMIFWeXTwsp2/qei26MiemFIg4U/RZ48pM+A51xaufgXq3R9OvawZZuIYA/BFIgJYgOY+JJ2MpKoh/OVR/nVyf+apVPYZMLZsx5D09N+0EQ336JvcCiZ1zC0i7A1qcF6QIBvkzIaXCnbw9sbJBaWWGCjc8TkqiirPfb+EZ4ivl2nZbeSZv//y4e8SbG1+VH19l+iIM/M7jMnnL+m22Xg4k6gft+sRWaJd34pWSshTjHoO2lkOjMeHB3YPHMg31czQeyLeOOTrhJnVXHk44HK7MiaGe4AvMgAsHIcRFLfdO3N2wnJH020GZCIZJs3QcMetTp+/H4jZdwY+CfkdnE1l8d25t4Pt/Rf0vPOKfTnj9GcBMbZM9iqBCmgzO1sGSeiQnJ6V5pz4bxk6wbH0efiidf3ZJmLUKHdqQ==;5:fonPYKzF/Y4HeHf0nwGT8KWH8SsQT2hpkR3PWy84kl2/bsS5nAZoUziKdji7kag27gngi4io1U4XVtLrGZCeUzS0nggiWSGsxikHBpW+FLEPLVPynPUynUSMm78mUs5pejjtqrykKT8d3rKz6qTkfMLtrl1vGQRzc5wLbvMKZm0=;24:N75vfftHS8SfvlOrUc8XZ5SPvhF2cEOGMttfEN+sIvp/wHIgbBNRPfY8BK4palHBE1d9fIL3IG9rBa4/Jk4TzQvmUYmW2C2z0eggbq04Ao8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;7:jQVGkiOTkrDiRyNlSTRHSR0775dfLaq3VG2YBEltLTduUyKamgftv7g7Y0q8XqM5A9vPmwJt7hDMkzFyyUMHFmioKbNNoVYnCpms3TFS4+DZ+ALlPiBoGoERZJpdStdi6B3dvJp/IeIY+YMc46ecD9CECEStCfkmRHIeEE7+dTMqcHUwwnrtgx1PfR6/Q3EgzUbJfCxRDHe28EPfzLCFc3YF1e2aNX5qCJwSb91nf8t2uPm3+HRH1im5L+hnu4ZY
X-MS-Office365-Filtering-Correlation-Id: 14eed720-de42-4ab7-3cb0-08d5c5ac722e
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2018 21:37:57.1910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14eed720-de42-4ab7-3cb0-08d5c5ac722e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2463
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again!

I have spent some hours bringing out the old hardware with the 1024x768
panel from underneath the usual piles of junk and layers of dust...and
tried the current kernel on that one. And the display was stable even
when stressing with lots of NAND accesses.  *boggle*

Then I remembered that I had lowered the pixel clock (from 71.1 MHz to
65 MHz (and reduced the vertical blanking to maintain the refresh rate).
I didn't notice that this fixed the NAND interference, probably because
I ran NAND without DMA at the time? Anyway, if I reset the pixel clock
to 71.1 MHz (without increasing the vertical blanking, just to be nasty)
I can get the artifacts easily. But running with a pixel clock of 65 MHz
is not a problem at all, so we can consider NAND-DMA with that panel
solved.

However, now we know that this setup needs relatively little to start
working, and that might be good if we want to see if other changes has
any effect. I will look into that tomorrow. And we can also get a grip
on the critical bandwidth.

But first, answers to some random questions...


On 2018-05-29 09:25, Eugen Hristev wrote:
> One more thing: what are the actual nand commands which you use when you 
> get the glitches? read/write/erase ... ?

Erase seems to be least sensitive, read or write are worse (and similar)
according to my unscientific observations.

> What happens if you try to minimize the nand access? you also said at 
> some point that only *some* nand accesses cause glitches.

These systems will normally not access the NAND, but the displays look
like total crap when this happens. It can happen even when sync()ing
small files, but doesn't happen for every little file. Writing out or
reading a large file to/from NAND invariably triggers the issue.

> Another thing : even if the LCD displays a still image, the DMA still 
> feeds data to the LCD right ?

Absolutely. But since we are not playing some large video file (which
could have been stored on the NAND) we typically don't see the problem. It
only turns up in special circumstances. But these circumstances can't be
avoided and the display looks so freaking ugly when it happens...



On 2018-05-29 17:01, Eugen Hristev wrote:
> Then we can then try to force NFC SRAM DMA channels to use just DDR port 
> 1 or 2 for memcpy ?

I *think* my "horrid" patch does that. Specifically this line

+			desc->txd.phys = (desc->txd.phys & ~3) | 1;




On 2018-05-28 18:09, Nicolas Ferre wrote:
> Can you try to make all that you can to maximize the blanking period of 
> your screen (some are more tolerant than others according to that). By 
> doing so, you would allow the LCD FIFO to recover better after each 
> line. You might loose some columns on the side of your display but it 
> would give us a good idea of how far we are from getting rid of those 
> annoying LCD reset glitches (that are due to underruns on LCD FIFO).

I noticed that the 1024x768 panel is using 24bpp, not 16bpp as I
stated previously. Also, the horizontal blanking is 320 pixels, so a
total of 1024+320=1344 pixels/row and a pixel clock of 71.1 Mhz yields
18.9 us/row. The needed data during that time is 1024*24 bits so
1.30 Gbit/s. For the 65 MHz pixel clock, I get 1.19 Gbit/s. Assuming,
of course, that the pixel clock is actually what was requested... What
is the granularity of the pixel clock anyway?

For the bigger 1920x1080 panel, I have a horizontal blanking of 200
pixels and a pixel clock of 144 MHz, so 14.7 us/row -> 2.09 Gbit/s.
I suspect that no amount of fiddling with blanking is going to get
that anyway near the needed ~1.25 Gbit/s. Besides, the specs of the
panel say that the maximum horizontal blanking time is 280 pixels.
Seems futile to even try since this horizontal blanking time is so
much shorter for the larger panel (fewer and faster pixels) and the
longer time wasn't enough for the smaller panel to catch up. But ok,
in combination with something else it might be just enough. Will try
tomorrow...


On 2018-05-28 18:09, Boris Brezillon wrote:
> On Mon, 28 May 2018 17:52:53 +0200 Peter Rosin <peda@axentia.se> wrote:
>> The panels we are using only supports one resolution (each), but the issue
>> is there with both 1920x1080@16bpp and 1024x768@8bpp (~60Hz).
> 
> Duh! This adds to the weirdness of this issue. I'd thought that by
> dividing the required bandwidth by 2 you would get a reliable setup.

I think I might have misremembered seeing the issue with 1024x768@8bpp.
Sorry. But it *is* there for (the old variant of) 1024x768@24bpp, and
that is still only 60% or so of the bandwidth compared to 1920x1080@16bpp.

Cheers,
Peter

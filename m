Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA2AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0969221A80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="u5Lj0PbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfBKMKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:10:46 -0500
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:8512
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfBKMKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMZ7vOfiq8M0jmHeJSi3rnYA+rtToe2L3idNXRkZR44=;
 b=u5Lj0PbGWggMMuByTwGF+lXoQ/GXT1htB5UIYgxXbAvh4YZyTFVrxQvipr/BSwupDSBS18220gdAdiy9dvLwORcXHVgphXcNGfuLAkcwHTWWuHW/BzWIMTpo8oi8+XaFBc9XTaR6n+iSdhsAOy7u8fcmZCtASPPeEayGisoVzt4=
Received: from AM0PR06CA0067.eurprd06.prod.outlook.com (2603:10a6:208:aa::44)
 by DB7PR06MB4725.eurprd06.prod.outlook.com (2603:10a6:10:56::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17; Mon, 11 Feb
 2019 12:10:41 +0000
Received: from AM5EUR02FT026.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::206) by AM0PR06CA0067.outlook.office365.com
 (2603:10a6:208:aa::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.19 via Frontend
 Transport; Mon, 11 Feb 2019 12:10:41 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 AM5EUR02FT026.mail.protection.outlook.com (10.152.8.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 12:10:40 +0000
Received: from cernfe02.cern.ch (188.184.36.47) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 13:10:40 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Mon, 11 Feb 2019 13:10:38 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Vinod Koul <vkoul@kernel.org>
Reply-To: <federico.vaga@cern.ch>
CC:     Jonathan Corbet <corbet@lwn.net>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] doc:dmaengine: clarify DMA desc. pointer after submission
Date:   Mon, 11 Feb 2019 13:10:39 +0100
Message-ID: <4742302.Qfi8ekQbNf@pcbe13614>
In-Reply-To: <20190211115411.GR4296@vkoul-mobl>
References: <20190208153038.23272-1-federico.vaga@cern.ch> <20190211115411.GR4296@vkoul-mobl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(136003)(2980300002)(199004)(189003)(478600001)(14444005)(23726003)(8676002)(8936002)(786003)(16526019)(316002)(186003)(9576002)(46406003)(230700001)(43066004)(33716001)(6116002)(54906003)(6916009)(2906002)(305945005)(106002)(7636002)(7736002)(246002)(50466002)(3450700001)(33896004)(6246003)(44832011)(229853002)(53546011)(446003)(106466001)(426003)(97756001)(356004)(26005)(4326008)(74482002)(47776003)(336012)(86362001)(9686003)(486006)(126002)(476003)(76176011)(11346002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR06MB4725;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e44b5c01-6110-4079-94d7-08d69019f0e5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:DB7PR06MB4725;
X-MS-TrafficTypeDiagnostic: DB7PR06MB4725:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR06MB4725;20:mBiXs9dEzQepA7qzsNMp9WBq6fZqYDlmsjQZirRP2Nuvk9uPN8W2QAPrC42/GA8pTMalsbreKWheogDCnPmvvXp7ElDw0F6jl4VjqWOfAOE5SmT7iud6hhHmCXuMgk3hZwjNlJ5U1Wl8I2AaPn19mN9HGOm76+u3ymuB7kBEi9DaYhjCJUqbYKUS5kvXaIsVOjiJ4BOJQhkShwWh91xOehGhVeSFwwuAcFSOIDT2aTgxY/BI9Med55agpOxMIPWfNw7obAnCNrS9P2gDsSMPS0yh90ki9cTW4op87QYhlQ5eOxnNsq4LXQ9iMdK3CJaeEKIiS+dTwnkY1/7NOzXQvdc2DyHZzLSKD/YceY4JRenKv0ATnXgZSIVECga3py+tcu5MgrXq5POf26OExAZH9SwSrndHL97r/ikxKKr55ck0QInpynxeO8LTMVQo9LjMIbqUwyUgi6DRkhQZACOrruc0T3xIKpvaaScy/+3r1NGlhEvOHIyyGn2WF9PALnip;4:ET6X8zpoIeHtl1v9dib396phQn+M3aexqmXoEkNLY1gtZJtZWZQgRk8JvMJTJRK1oirXzcbspReQn5W51z5drc6tgJAATIcvQ83wXvCxWB+KBdJksoi5AGNZkpJPY+KdxmPz+ZtrF105b7zW5uHhLd2n4ALvvg5gUzpgHwgIkPL52u17WQy46WaPFzPPP7kK+vfNnfGjCzjoDWtXH2qRz5vJd3PgjPZw08n36xkq99zE/TzHIDNpqszwYF1YYRh8kyPhlpBm19CKQygdjW/bvnfieiTjKYoBfZbdrO6cRIXimZJ0b8V4uqAS7Q2mHwDh
X-Microsoft-Antispam-PRVS: <DB7PR06MB472527EFF54F9C73F404A9F1EF640@DB7PR06MB4725.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR06MB4725;23:EETIn0RYPNYDjDozHuQOxklOM+OHfxRDLQlu4Fzm2?=
 =?us-ascii?Q?1aG+EyKjY9XMFaygYDkYW0KoWyS916uD4+8L3Is2C+nnvh4gg69qEwODRX4f?=
 =?us-ascii?Q?ruJh3TSx0l5V+/GiW9LDW8nF0tkR+dmKtHEOTh8xkYA+J2Qpghuv9faAa8+R?=
 =?us-ascii?Q?UBcDDScPqKqZv9SDkXMBVCT42VDtwc5ndsjLo6hXaVo/QkyXTut91/7q5bF/?=
 =?us-ascii?Q?qG5tyxRctL4p8MmMSkQ8ikHnsP/PuIr4Y1sBWLzaXTxpf5yyPXnt8BBV/GHW?=
 =?us-ascii?Q?QehH5iUmliZKrXB+EWb8Qyvh1n71n7vq5V7zuPzpsZgur93FuRM8sLhtmrMT?=
 =?us-ascii?Q?FU9YBN++2t5aKbX8OY0ANs/T6H70N7jwvCK5nFRUHlJsdxoDByeo9rtwtN+L?=
 =?us-ascii?Q?+BGDOFVWPeW1+aomWbUf/g5gUL6Hx5t1cTcSor074Of4DNx2Qrq2Y2+4pF6a?=
 =?us-ascii?Q?ozVocUfqHPqQG3qHet3u3ek1XsKKEE0dN1kxFvh605kLS4/DlIJ8ZQRo489V?=
 =?us-ascii?Q?DhJUy+nvL8Qpx+BkRukEvVEEA6i6nJ19lnz/+kUV552lC+RVXiUF7SCQQ62D?=
 =?us-ascii?Q?Dk/LHyG7g6xXn6kFTXZAMyHLlilCrPlkouh2ApSmkqx7DngVOeZQu8RTisil?=
 =?us-ascii?Q?IllMa0/JQqGkAvOa9Jr7m/ozo4/sq3qBELphEEnsN1ZsKZ8udyT8PJ58E8M4?=
 =?us-ascii?Q?7/wFOf6dVLavkm364mcQ4jQKxAdb3+nI90HHw2NpuBTHm06RFLNYyPLU1WPD?=
 =?us-ascii?Q?AQ1oWlto/FO6O3PuRoEzQq6OCNI9tVb3fFdhPiK0O+hWOazkNDXxvi6kTZHq?=
 =?us-ascii?Q?UNjw23LNOjpWJnP4/xVcLXJxIYddMHmr0ptnRfCnem+riwg7rnEDZmPnRtJw?=
 =?us-ascii?Q?y9ez4cOfA5Qquka/Qhg9KRPVx7e+5Czewev121p2quGBX0+PUZBUR/WeAm0n?=
 =?us-ascii?Q?Y3AMFvNUyzgYluy1AwVxzzwcJ/i66MZVWJ+AWHI4nreeLcKy5T8Ig4GMIna1?=
 =?us-ascii?Q?BKHKVfpNqHGhBTPeRPW8RY3Rfx2kyjWj2JxZo9JpfPEYcRNrETbIkUOgKcIM?=
 =?us-ascii?Q?awuObWBmphSatIFIWXOHF+hAK6Oyz60MFJ1ki88EXtSKF0Qa8sn/E7HZaDs0?=
 =?us-ascii?Q?ROQufm3xb6dtIyUoANaC2TISIBa6Zg184J6aJ6zYQV7MAWba61In1cYB4pcX?=
 =?us-ascii?Q?bejErBadx2GkHWbUFebZZFlq1PFCDpXcZJxDQezYQT1b2EiRFnzKDbpTA=3D?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: yR1/kAH/VltiwKuR6VgYpt/6AumgTeuS5YU41iDVitTao+Mp4E/J3M3xSWIyZ3c5Gl5ZZ3t7XLzGFJhaMAT88qDkcJLw94rn2z+0HWK4/MA8Wxd5l+4JDigaDqzI1dfAJQAWoKRX+Eu54qfJVGB6hlMqDWTAoDuQ4n4SPu5bc3qTB7fXj2OG+6AuVpsLZOkmj+46wJ+GBI8OyzSF5R74cEPSL7HCGRK4kzHPe8hFIK/lc0RDDSxfwr9BDBCZSi0pRYY2D+116ousuwYvz++7E1JP3aF0CGsi5KdLRzz5XlGX9V/ITkumwU77n6cIEaD+WSoretX6pcZPMXcbiObsqJu8zIjfuTnNTJn7akExZOmxrtNI0YVSsbpaQVBqtvQnlMjLKyI1aw4eIlL4/r1CXJF/SU83OG4DzMuPdk8QfF4=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR06MB4725;6:SBXV8715S/hga81ojnOBFv7dQ0BM8tnXF1umNv3stJ+p1UrMqV8vXnQs1lJhiDcsbKGL3dlXiXLXndNblPrFm+4N1I89DBKOStyI0zLOXnFrOAujwoG211av8NvyoTo0h8ReSsn5VrOo0QH6J6yswn71sP4KouOf6CKwmp21QF0+KOrI03RoHX04cSKaMrQFutBVo1oWKhXnuhlj529FBmHzmyLJDuG9MBmJjLITO5ArI6dBv3rKm9MEort3U34jLWojeEFDFZwtY6XMJ85mrUnpBLF6rO+24Vbx53pZb0ZVRpMdNA8UWRxg+aW5USAe2ohcpkVxM8BJKeW2cL7029Qj3hCIJr/h0EaRliaehk/76IZQZpVbKbK+bgkz75AJrdGh8zbuyKIz5uv7hJA3BN/nD7uVEs6aqSVlHh6YkH3fqTdkOztLVYr/dH7tKBROtKibocIZAGJldVuV88zo3g==;5:pWxUSS1gCSB1OkUNIHzvzvMGOieUCDCWgX7k9Wnh87bbyg6EuIlFiYeNgvgR+n5XeYLu4RbwWGIcUf2EM3jY7O3zaKAtYGwmXvt542ZcTi0LLGh8J8zDdJgAH0VeElU28ehU7ngeWjMEUv2y62jvns7TCSkuz+N/I+7KXwJ8oL9STsleMgRVURqalnxq1h5lZ2lF35nwoXNPWst6fEmlMg==;7:/KhbtBhhtFT+SduANjTi6XAO2Og+/Z/Kgs0xQ9r2PbI9LGPusK0GPTk28FbPqbiwvR2Qu8iBVPPDDatYV3XjH0xQwo7nyzVNqrN7xqe7r6kwWLB+lP/c/VggH3Rxs90oKqZPrX5NCcbk7yyPIHVWmw==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 12:10:40.7071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e44b5c01-6110-4079-94d7-08d69019f0e5
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB4725
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 11, 2019 12:54:11 PM CET Vinod Koul wrote:
> On 08-02-19, 16:30, Federico Vaga wrote:
> > It clarifies that the DMA description pointer returned by
> > `dmaengine_prep_*` function should not be used after submission.
> > 
> > Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> > ---
> > 
> >  Documentation/driver-api/dmaengine/client.rst | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/driver-api/dmaengine/client.rst
> > b/Documentation/driver-api/dmaengine/client.rst index
> > fbbb2831f29f..d728e50105eb 100644
> > --- a/Documentation/driver-api/dmaengine/client.rst
> > +++ b/Documentation/driver-api/dmaengine/client.rst
> > 
> > @@ -168,6 +168,13 @@ The details of these operations are:
> >     dmaengine_submit() will not start the DMA operation, it merely adds
> >     it to the pending queue. For this, see step 5,
> >     dma_async_issue_pending.
> > 
> > +   .. note::
> > +
> > +      After calling ``dmaengine_submit()`` the submitted transfer
> > descriptor +      (``struct dma_async_tx_descriptor``) belongs to the DMA
> > engine. +      Consequentially, the client must consider invalid the
> > pointer to that
> Consequently

I'm not a native speaker but consequentially and consequently should be 
synonymous. As fa as I understood. but I do not mind to change it if you think 
is better.

> > +      descriptor.
> > +
> 
> Applied after fixing the typo and added tag as Documentation: dmaengine...

I used doc to make the string shorter

> 
> >  5. Issue pending DMA requests and wait for callback notification
> >  
> >     The transactions in the pending queue can be activated by calling the





Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBF7ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E34C2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="a7ZKk1b3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E34C2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbeISSKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:10:52 -0400
Received: from mail-eopbgr60129.outbound.protection.outlook.com ([40.107.6.129]:29924
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731070AbeISSKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86HmZRcN3BeTG6+o/T37Q9uT+6alol7TpXgo2Niv71I=;
 b=a7ZKk1b3K1ZX7QiUZ0nNabw2wN48oqT79mpWRL5AS0kLc8l0rwCImt9oPHJtcsaeWFX/yv5B8/Jb1mf1qlp/2Q9AXW2zXHE2Le7zuHNFVDrya9xlT5/3qafL2domxYnsBAi4CmcpGq8l5j+2nwqfw5eo9QVHffA5oFRmxfx6MwI=
Received: from DB6PR07CA0075.eurprd07.prod.outlook.com (2603:10a6:6:2b::13) by
 AM4PR0701MB2098.eurprd07.prod.outlook.com (2603:10a6:200:48::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.18; Wed, 19 Sep
 2018 12:29:09 +0000
Received: from VE1EUR03FT029.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by DB6PR07CA0075.outlook.office365.com
 (2603:10a6:6:2b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.11 via Frontend
 Transport; Wed, 19 Sep 2018 12:29:09 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.241 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.241; helo=mailrelay.int.nokia.com;
Received: from mailrelay.int.nokia.com (131.228.2.241) by
 VE1EUR03FT029.mail.protection.outlook.com (10.152.18.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1164.13 via Frontend Transport; Wed, 19 Sep 2018 12:29:08 +0000
Received: from fihe3nok0735.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w8JCSUUO023725
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Sep 2018 15:28:30 +0300
Received: from [10.151.72.173] ([10.151.72.173])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w8JCSUnU023721;
        Wed, 19 Sep 2018 15:28:30 +0300
X-HPESVCS-Source-Ip: 10.151.72.173
Subject: Re: [PATCH] tools: Remove conflicting BITS_PER_LONG define
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <20180912170232.25258-1-alexander.sverdlin@nokia.com>
 <20180912190107.GA5502@redhat.com> <20180912192129.GB13738@kernel.org>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <562288b4-aac6-182a-6f75-23d32dbdcad5@nokia.com>
Date:   Wed, 19 Sep 2018 14:28:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180912192129.GB13738@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.241;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(136003)(376002)(2980300002)(438002)(199004)(189003)(336012)(65826007)(5660300001)(50466002)(65956001)(64126003)(36756003)(65806001)(106466001)(486006)(230700001)(126002)(446003)(44832011)(6916009)(31686004)(86362001)(53936002)(8676002)(356003)(22756006)(31696002)(76176011)(81166006)(8936002)(2486003)(54906003)(58126008)(23676004)(26826003)(478600001)(316002)(47776003)(305945005)(97736004)(68736007)(81156014)(2906002)(4326008)(6246003)(2616005)(11346002)(476003)(53546011)(229853002)(106002)(186003)(26005)(77096007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0701MB2098;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;VE1EUR03FT029;1:a/A5w7xbBvqxJC0KrUqlj0KCPbmVAXSIJ7DcoxV18Rl49PGl27oN8LgkazKIYSvwIEpjL5eDqSaG2Jo4BJVe3YCuwBKSSHqLBaH6W7w+tfo5osCAERgZlH0VisM9k+C/
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3aa91445-8930-42aa-e185-08d61e2b7f45
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328);SRVR:AM4PR0701MB2098;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0701MB2098;3:6jblLQVKo3Ojf7Cx/5Tl4t/hXRjstOZIei7ZjwJbs1kpZg4v9rKAXa4FFyTgwXNipLoGFd25p8iZPPkoSg5DQZzT/pMDb3HAHkUCj/f08KsygAlfPId8X5fKvNjgaXvtsbyZKN5KslsV3+usFp25/6uAdDvERzcyLkx1aKRf7WcW3xq99jErtPQXQ3AZauhx0dbsnqmqRBmKUmljcPmgGLLUparMqsFEJqvvtWnAWXCR2O8/mvowFI75JOOuEC2XS/hcZnN1B4r8TlqYQesE90d7tUYf2/Iv5JK1KssOI/Ln28N+JmABribrnLk5cwGu8qEzvOsO8wSyMgdruCAAmp5oR/PmVie21OelWrKFPG8=;25:hN36fgw2NVMgWtMiIVC2IdMdUcq1DgTx9N0RB+YcLtvAsTIIbzqFNzl5xdOlYp4Y3wRgfrE2dLYLwStKgbPogzPj/Xe55i5wgJtgpqrSyBBwmcREA7/cM9hY8NmfDw5lT8XrJ6qexViRefIrfNXygYWmxuQoE3KMb6mwy4vFKygeIeDnJlsjsAnSmHA7nSZOWArbB8+nAst5KeYRiwKP6tsejMphNnEF4c4WYbtdnzKjgeNVEfMEeiHoPkoXq2DeZ1Oc4Kz5zg2ii/zq80mjNmaOc7K5fzZzBsegJjyxmoJwS+lePgNM9omwKEbT809/rDtUqbyHU4EksZlcsS18rw==
X-MS-TrafficTypeDiagnostic: AM4PR0701MB2098:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0701MB2098;31:STIv/5ATfsJ25umqjShtdZL1H16wKzRhUbhYBPW1Gh6QzeWBy5MHTDek0Pds3RlCtFB+sRwoqPTTEmg7PTyAtClD5STtdHhA+jaKSAyMJn0dGknVhjcyVfxTpvr36hJn65+ahCY868PBO7dlVqOo+zcZdsUcBUHtoBYirQ2OLEdQbcKUFhFA5Iky+1gcnuK25eR7jIpcZFKFKB8I5SiBy39TIZJU28I82VKAqcRmdmM=;20:+GUclHHXyPBJlAjjQS+3KEDJfOmI1jhUHWxRfGtoHp0rKSpb8xfO1YnTFT+hF+i22/bYgXeGa2Zmt8730GnYttKmIk74/D2YWTaliO94aI1EL+RYabMVmPeFKxXpGHtwN19bOdSwdp/tKFJmiw4jOUYzYVQsUoSvKJsdiPvebbkD60tFHOTSzIE82/2XhHwLO8K1cmDMRLXrrH4o18divUvc7PFLlOEv0OVat9+hM3uz7+LGFwRhtn1ovFV5Bd3nx2RMIFOuaJ7snA4z9NK8CmmqmO8O4HSwGSvR9W+pRSklLQq7lCDg65zLN1yy9HDVY2at/bNtIVuwyXqndkiparaO5TW7pe9vGs+GKotXGWKFcW10oUBt1rS5g4K88H1kqt0ZAYyKzS+7509rxSBRRpsI/c10c+PuocgQNi5EvJIT9ZZwyntTOZk3c4VD19wi9MrJ2loeUIc/MtuVKVVYCfItgYMhkS70ghQoFPIi0M8AF7wzAQHwWlJcIGcGCW/Kg5MVo8lubRY7dQyysLKvXuZJjTLtcjXYB7i07McT3bYZsrEssCyrEVFRkaIpea6jBzJQLjX984WsHkrM4vmZ+B/8JRTRnE1D7JSrAqcWo20=
X-Microsoft-Antispam-PRVS: <AM4PR0701MB20986BDD02E922E78F8B8CCB881C0@AM4PR0701MB2098.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231355)(11241501184)(806099)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:AM4PR0701MB2098;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0701MB2098;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0701MB2098;4:6X3Mzm1QMcXykmMntZysoEITNqiBvhwjdN/d8g/MdkDMLu5etvHyWY8LerKh51jhSJiN4q7/+a4MlPVyT31qMbOoAWF2LmkHHSvz23wl0qas6dwlVbrc0502AN/m1hyXsVufVcD1W8lp4RPtxeIAVe9TGjBpgFlpiBewF9GDjHH78fCvba2shtbOhGS4ll4S8qs4vckocQttWodo1eutApgLbqia5a2p9j6ufxEyiSR357H0ZBMCy8K0CooGMuh6fptKRS3cO3gKw4t3mWwrfA==
X-Forefront-PRVS: 0800C0C167
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjA3MDFNQjIwOTg7MjM6eGpiN29iQ045L3BoOGF1WVFNZElPblVa?=
 =?utf-8?B?RTc5NkUzeGVYQ09ZTE5iU1FMZUY0S0lYYWVWZFRHZ1cwTlR6emk2dXhKQ0Ur?=
 =?utf-8?B?MTVhY1piOTFDRlllMExDYkhrZ2hRbEJOamNmYlQ1ZXd0d1hhcXNNaUlUc05l?=
 =?utf-8?B?LzlzRWlDL1REY3NldHdLOWtUTG9WcEllUy92TFhtc2Y5d2hZUWpvR0xzY1or?=
 =?utf-8?B?TXZXaFUvZ0JUTjNKMjlmS243UTg5UG9KcERZVDlsSVlQczVzTjFJRFhtanR2?=
 =?utf-8?B?NHVncWZWMVpabmJuLytBd1ZPNktSRzFia1NsalFBMDQ1VHpZNloyNXExSzJW?=
 =?utf-8?B?WXliYWIxSTB2QVJqbkV4Wjl3Y21wd1NIVFY1WUdHei9pWURyTHNDbEZrT3N1?=
 =?utf-8?B?SnhYSXhsUUowNStvTW16U2ZBaDAvQzBQVEV4aFlQZHgvWDF5V0I4UlBpM2tS?=
 =?utf-8?B?ZGxHWUM4b2tFVjB5YmlyTHNLMjJsTEhpejlUUkdLY3IyQWplUWplWTBFbXk2?=
 =?utf-8?B?eFh3SGF6RlU2b2FBY1htL1YyRzdEZDdEQUZjcTZPY2I5WGZnZGtKQ0JuZGpN?=
 =?utf-8?B?blhNaTV2N2ZjRWsydmVsTU15SWxiNzNhaEdtaW1hSVA2ait6RTk4ZEJWM2Yz?=
 =?utf-8?B?NVlQWFQxSmx4S3Rua3M1YUtieGw4aFAxZ2twRWFSQ0lsdEdvMW9VTjNURUNs?=
 =?utf-8?B?T1ZiamxoSnd1YS9BdnNEZytLQmIzZUJaK3MrbkdPcklIeFZIUFFuRFZ2b1hR?=
 =?utf-8?B?QnROd0pIS0NDNEg4MDc4Zm8rQ1pjcFZjK1V5bW1GNkxNMGNHQ0trV3dmaVZM?=
 =?utf-8?B?S0s2QXRRV0hLQU9GbUk0M1ByR1RHN3BTUnN5b2RYWUFsRmdueW1JY2plRnVi?=
 =?utf-8?B?OWZUd0xjYmJUUFE2eTVlWTc0cTlkS01hODFUenFDMVBBTW42T2pPY2RmbE9O?=
 =?utf-8?B?VVdOdE5TVnVlMjBkTHcreUVvbGVwK0s5anNodUdzUitNNG5BUTNjcjRyckNI?=
 =?utf-8?B?S3NTbWs4QlQxR00xTUdvUk1QWWhOd2Z0cXU1OXFOZWlZWGJ6MW1Hd1dXc200?=
 =?utf-8?B?Q29OK2d4dVBhZk1tYXBiZ2VuaGtDN3NjNWh6TmxNWGk5b2h0bkZzSGhPYzRa?=
 =?utf-8?B?eXRKNyt6RGEvV3FjVytuM3B5QVIrd0MvNjF1TEVEZCt4eHNtU1J4S054M282?=
 =?utf-8?B?ZGtoMTBmUDBHNXo1MXd1MGcrNEUxMU00MkdWdXg3THVnekJ1OHU3OFJ6VUlP?=
 =?utf-8?B?ZndoeVQ3aEtLM3c1dmRiRy9hMitUQVlNYTNORmdMUnlLS1ZBcmFET0Vjc0tw?=
 =?utf-8?B?MWFaVW9CanVST29KQTV4M0JpZDY3ZEJERkNSK0o3OFB4SE9RM0RPeWgyS1Fh?=
 =?utf-8?B?b0lML0lScGc3OFFkaWM5T0RkeFU0a1ZUcDdvc29JT1VFb2VOZUZOQjJuYlVh?=
 =?utf-8?B?KzhiRWhYSDNaeFRBUUJiY3NZWUxaNDhOWHJqZDNxNC95V2xFVHUwamVFa1c1?=
 =?utf-8?B?cXQ0NHVHbmZUODZCUzI0NUQ0dWJ1N1F3WXlIMkZILzdJS2xXZEJ4Z1RLdVYr?=
 =?utf-8?B?ZGU2dktpTFJqTDYxSTllcHRFcFF6VmtsY04xVEtkWTFiY2dkTWZ3VUh1Rk51?=
 =?utf-8?B?Uml0dW1BS2Rma0NvYjBWUGhxeVpiQTJpMlpGM2w0NERnOWliRTdlczF4amNI?=
 =?utf-8?B?cnVXK0gxbHNGVmN1V3hnd3Zvd09HNG84ZG43by9KTUVnOXJlaFp6UWhVMHVj?=
 =?utf-8?B?a1lmbzdiU3FSeVNyYTlkWGxnPT0=?=
X-Microsoft-Antispam-Message-Info: d6h0rV/ttAmi3hJXZQXKvBgngOGaaXVKgm5f8XnIzUaEPWPFh+MxS6zLZox2YUTN7AQqGrL73c2zicqaup14hLFr0d8UkURMULgrXtvXw5nPjT+arLHNYa4E+enOCAjUNndttyxSNnHchqW5X+kFy58du9bWLvMOdMEV7Py/q8yt02hfZ3XDHVV8sXHOry6qtaY48BhR5VujF4Gj7nLFnpzpAkBmn3nc8mA81JNFNUEziTthlkCZ7+ForPeQF02JldbzUqZI+cLnOCZK1z4ZIQX15iIoorsA3JY8rFH+zrIyi6xRX+PV5IvegBp2hZ8KgDluGlcgZ58N5v5rpWJlwXmw93U6gJidv+8ZbtDjAvPDszABV183tLIqN8GGs+JIT9YiUyuV4Rtemk0RBih3Nt+6uKZVCCYCUChGg0G5rIUgOMit/v3YeE7jrOeCTaEN
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0701MB2098;6:7pxQywaTcHCvrZckgmhZARo/UUJknvwBRIy+GqL581oMcpex/6nBL5R0VZowexZX3asxsj7gfjTVqkxiSg1OJxdXqNUrZmqHxW/09EqqYuyedjNyKToYKFx2oP5ySaroJQ+6ocs33VstA8FwutA8oOVQDVo7jnsKPhw9kiH98Ud5owpKhHGRF+wxhW7LfOyhafoGhAzj/vTTVtiVn2LGaURKrIDCHXhssH+lFcSvHcWMZ1GtrbOQwHycaWX5nS8jimFDE76k9UYvQAUay5ot5jO/kCXNhGA2zqEOzusee+Uq6Yd803YL9CDHClR8BcxKGRAI5KNkptj/BXZNFt8oY6xn8LA7Cjrw4aRZI0jvWrJDjKunG4dcaKlYdVlNcUpCjohjZLvWyWcBQ1VpXyprO/QU6M26H/Tbmk3He2Z2qO1cRs9a5sYwpV4GEUUt6wXfGEfnc6ZX2W98BNSX8YtC6g==;5:yKrzvZDgL0rb2qh9odyppTMRKRtuPYFQaqa2nswV6+cqqlwd5YisVlm/iAQMX+dMDsvUPBmsx/ujrMwuAEbxjOI07NlDPj1rD9k2alkImlco1f7q0HfqJnFDpxBDDeeK2nk9bCtz+BmVk3ciPVTAEqbSJ+tKWeFSJ/33OWv9QW0=;7:U5difVyFV3X+avsRvVFHIysWFyrKlE2B6ZFSV/oZ5zP4fPnOR9MHNtemuMZh7L7wUfPWb73zBiKLa2CDcOkBcqwKBY9BpmMPHuxzjUuMwt3Cb8FJM9yTy/ojboxYg0Qp91DHqKwKeUQFqmkycwigf1iYHuZ3LiSSeqf0uViW5oPQ5OAfklCV+hLoT5IrE3EuWi0J1mXN5vFbySZx0BSRlnk/5Ye32D2atnc456GOCQoQihp1d6WLK3uRQz2Na1go
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 12:29:08.4873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa91445-8930-42aa-e185-08d61e2b7f45
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0701MB2098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2018 21:21, Arnaldo Carvalho de Melo wrote:
> Em Wed, Sep 12, 2018 at 04:01:07PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Wed, Sep 12, 2018 at 07:02:32PM +0200, Alexander Sverdlin escreveu:
>>>   CC       .../tools/objtool/builtin-check.o
>>>   ...
>>> In file included from .../tools/arch/x86/include/uapi/asm/bitsperlong.h:11:0,
>>>                  from .../tools/include/asm-generic/bitops/__ffs.h:6,
>>>                  from .../tools/include/asm-generic/bitops.h:16,
>>>                  from .../tools/include/linux/bitops.h:35,
>>>                  from .../tools/include/linux/hashtable.h:13,
>>>                  from elf.h:24,
>>>                  from check.h:22,
>>>                  from builtin-check.c:30:
>>> .../tools/include/asm-generic/bitsperlong.h:8:0: error: "BITS_PER_LONG" redefined [-Werror]
>>>  #define BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
>>>
>>> Include <asm/bitsperlong.h> instead as other headers do.
>>
>> Please try test building all tools in tools/
>>
>> This broke make -C tools/perf/
> 
> Also, where is the build of objtool failing?
I've prepared some examples for you with "-fdirectives-only -save-temps":

This is what happens ultimately:

In file included from .../tools/arch/x86/include/uapi/asm/bitsperlong.h:11:0,
                 from .../tools/include/asm-generic/bitops/__ffs.h:6,
                 from .../tools/include/asm-generic/bitops.h:16,
                 from .../tools/include/linux/bitops.h:35,
                 from .../tools/include/linux/hashtable.h:13,
                 from elf.h:24,
                 from check.h:22,
                 from builtin-check.c:30:
.../tools/include/asm-generic/bitsperlong.h:8:0: error: "BITS_PER_LONG" redefined [-Werror]
 #define BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
 
In file included from .../tools/include/linux/hashtable.h:13:0,
                 from elf.h:24,
                 from check.h:22,
                 from builtin-check.c:30:
.../tools/include/linux/bitops.h:13:0: note: this is the location of the previous definition
 # define BITS_PER_LONG __WORDSIZE

And this are relevant parts from builtin-check.i file:

# 1 "builtin-check.c"
# 1 ".../tools/objtool//"
# 1 "<built-in>"

...

#define __SIZEOF_LONG__ 4

...

# 1 ".../sys-root/usr/include/bits/wordsize.h" 1 3 4

...

#define __WORDSIZE 32

...

# 1 ".../sys-root/usr/include/bits/wordsize.h" 1 3 4

...

#define __WORDSIZE 32

...

# 1 ".../sys-root/usr/include/bits/wordsize.h" 1 3 4

...

#define __WORDSIZE 32

...

# 1 ".../sys-root/usr/include/bits/wordsize.h" 1 3 4

...

#define __WORDSIZE 32

...

# 1 ".../tools/include/linux/bitops.h" 1

...

#define BITS_PER_LONG __WORDSIZE

...

# 6 ".../tools/include/asm-generic/bitsperlong.h" 2

...

#define BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)

It could be that your compiler doesn't define __SIZEOF_LONG__, while my does.
It could be that it's caused by the fact that I'm using a "cross compiler"
(i686 compiler to build x86_64 kernel), maybe I'm just using a newer compiler
than you.

-- 
Best regards,
Alexander Sverdlin.

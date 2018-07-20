Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D035ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367BF20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="gvIQRk5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367BF20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeGTL2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:28:16 -0400
Received: from mail-eopbgr50098.outbound.protection.outlook.com ([40.107.5.98]:54929
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727216AbeGTL2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEes1lQ8OmPFZjn9yL0bt/fI5c7bFfZ5l5BzsBz+1Nk=;
 b=gvIQRk5bv85kO8uFkVU766T2VlxS+LuNQpqlxKlCAyFRj4Uc0hKEUlwSTrJVmD0OJH8fTx90gA/Tzosete/U3dbW4clutK5Yb+TU4qVC8CyZ5A5gnqDXZ1r8w9UPudM1rFBXO4pMPvcwF/GE+jsJg5huzVAx7PXmtbrJYFB0cX8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 HE1PR0201MB2459.eurprd02.prod.outlook.com (2603:10a6:3:82::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Fri, 20 Jul 2018 10:39:40 +0000
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se>
 <20180720120518.445b947b@bbrezillon>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <1a2b7588-9c2e-a25c-6bae-5c8c8675667e@axentia.se>
Date:   Fri, 20 Jul 2018 12:39:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180720120518.445b947b@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR09CA0063.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::31) To HE1PR0201MB2459.eurprd02.prod.outlook.com
 (2603:10a6:3:82::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37ab4ace-227d-4eae-9399-08d5ee2d19dd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2459;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;3:qotrX9ebZYVKvjXE6fv7Dvo651MPu1A2/w10xqtvdOHCP50n4wPTTPnXN6YG44/5pTTNmoNP9wAnlB54K2unYUBSZXi2lAAFPUCKlJaFyH+znk+SJkc+CQrWjrZKaUaaRKYoVT0u03qLJj4ZzpHhyTvx72ANKsCKe00NbYmzZx1pOxdJZHqOD/bCtWI86vt7eAhHE1JJxcCzRsFVfRAfrzIeDGdbRcalZwYYcnxdtaJPK57U0X8OfwQ5F2n6bTQ0;25:ZAQMC0dLzu3CG39f/dtCk8RlvePDiSXTdG5APrpnGD2bpKmcDoMqYXCMOXIATz16hOL8QL4YEQhPR0jx58Ss0QkHDhcHxWmAS8Cesj9zn4J90bcT6TuI8qvs91YrP1Tsd6rKq8ElFcsqoVJRkJ4/9PCwyHjmjb+UnUZAF6uAGN05QQVjuNF9KJsFd+qi6hkoXC6Du+JkOJENcoO9D4hBOoqirvh8QkVLqJVL8PDd0C1FjL6VUadw/gNHr0/Xp96dQqVx5GWO73dJI9pjR2Ao8cfOzVLuIWWl6gh9udyhvHECGE5jzE0sdv5nJUyyH1wxghJ5oImNGkuFfNvNp03mvg==;31:+QzFYJo/wLr21jOcCiajdmCMMsRA+f0PNW6b3fkcFMiQREZvOSVJJrWRQGqBIz0dMaKzm/yOKObEAiqImfEdZIt08A1zO5ktCAoWEFiapdaljrsNxkzt0v+DJ2k5IfCUIJpgMhnont9pQmE8BMQfcqAc5nfltV72LNk8duCeCA4/oVwSxOlY8aWcssGG4nesAvILMdULGbfgrQYjzu7FHFPLGbP8Hc289nYmLgW2kqQ=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2459:
X-Microsoft-Antispam-PRVS: <HE1PR0201MB24593484563528020AB5222CBC510@HE1PR0201MB2459.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:HE1PR0201MB2459;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2459;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;4:soAHQNyjxcn0ktJ7J7JafIkoOZw84HZ/E9OshylEE3QF3bdOayeOumqAStiVFVRCps9U5xmQiml+lunW0gRYjzUBcKFO510geqpNyigos3U7oDRSMkLhpp+ygechn12YGf9RqD+Ya0F913lBQAFF/qeQ6bUCyAObTnCmTt/vMmf2VvjZMIWq3pqmiawFrWDoNLUKoNJNtq9f8IO94zhqLqO1iVfGz6eBUcLi0ur8LfcfKo10qXTnlB+ThUqr54fA5qtTDStpO+cjeF1Cx/8Pzw==
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(136003)(39830400003)(366004)(376002)(346002)(199004)(189003)(229853002)(36756003)(6486002)(230700001)(47776003)(66066001)(7736002)(4326008)(65806001)(65956001)(478600001)(26005)(305945005)(117156002)(93886005)(77096007)(956004)(476003)(486006)(11346002)(446003)(2616005)(25786009)(53546011)(23676004)(52146003)(31686004)(36916002)(2486003)(16576012)(316002)(52116002)(76176011)(74482002)(86362001)(551934003)(31696002)(3260700006)(54906003)(58126008)(106356001)(6916009)(6666003)(105586002)(97736004)(386003)(68736007)(7406005)(7416002)(65826007)(5660300001)(16526019)(81166006)(8936002)(81156014)(64126003)(186003)(53936002)(6246003)(3846002)(50466002)(6116002)(8676002)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2459;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDFNQjI0NTk7MjM6UVdLYkE2SUE0U0huY01LU0lvaENoSXoy?=
 =?utf-8?B?YmE2OHdTMStpUlNKWWdUK1loYjdKSHRXcmxqdWp1ZEpYOHIvU1UwamQyVzI2?=
 =?utf-8?B?aElLNDI4by9KNG1ZRk9MRHBqY2xhQWpFV09JUVQ1VHZSODlpOU0wZEZyU1Qy?=
 =?utf-8?B?NGhqcm5kRUwwMUw1NG1OYXRaZzQ2MW5INHAxK05kOFBDaFZNaHFBMUdyVkxw?=
 =?utf-8?B?YTI1dzRSVXRWTG56cEFBS1dkdGk2OTV4bGdhSlRGaFVraFQydkI1UmpJSWEv?=
 =?utf-8?B?MVBmb3FMT1RFTkcxcHpDazJoaHFmTjVocjNxUHd4TUhwWHJwOHBNelBUOUpm?=
 =?utf-8?B?eitOWDhwUTBIQnB3d0hKL1prU2tqNFVCVUZoYnEzV3h3bGJWYWFzZmpTckFs?=
 =?utf-8?B?ekdPcThDUlF4RXlrY0VvK2hPRnRrWDdsQmVyWGdnRzZnbzM2RkFSM2JmK3J2?=
 =?utf-8?B?TElGdDd6aUFPNE4zblRTdHhmQlJlcEpGc0hWK2JGTlcyKzkyQy9FalUwVEJx?=
 =?utf-8?B?S1RPeGt4c05rRmxlSmZkQWVnRTEwWkpFdThmZ2IwckppT2ZSTnVZbXROMWpp?=
 =?utf-8?B?c1NERzg4aWxUZkZvSllwdm92b09iaGFzYlplZmI0MXFFMTJoa3dFNmdOM25w?=
 =?utf-8?B?T1RvUmVKQzJiL3NCb1dscnJManVYOTBQRmFQTi85STdLdmtmanpGZ1NMd2E1?=
 =?utf-8?B?KzZVQ29YNDlsZ0czVmVPVjhJazZIeFUxMGtDN0JVYzF4ZGpxYnVuTzNISFE1?=
 =?utf-8?B?OWp3VnMydmlPWTFja0M0b3FrckRaRy9HVG9iaStHUUNieHRxY3ZoSnl1c3J5?=
 =?utf-8?B?VjNKVWtyeHdWcUdzU2RhMkxwWk43THlPbkRUelJ5bTdNd09XWkphUy9FTjNM?=
 =?utf-8?B?UGE4cGxUZU1mVEJBbkl2cW5lcSt5QzNBSktQVWRhOERWV3ZkaUU2ZXJ5bnFU?=
 =?utf-8?B?VTFXU1JRUFpaVkcycXhvZXRFZmdnWm15bmN1eGNTdE05K1dOWi9sSExFV3pU?=
 =?utf-8?B?NWF2anorOHVwWWNnVUhqNzA4R3orTVlyTC9DWG96R1l3a1YyRnpEOW5nc0U2?=
 =?utf-8?B?MERKQ0hBVHFGM0VHaXVLNWdxdGllYW0xOUF4dUVwUTI3N2ZaZ1ZnYVJHQ1FK?=
 =?utf-8?B?WHVQSkJoOFRZcG93N1NmcU0zM1hRM1Q4dlVLTEhVc2Q0TU9BTGR0MHlHU3BK?=
 =?utf-8?B?anFHQWhNbjlJVHhTSlNtUjdXN0hCcjEvTUdyZUNrMHJuUjYrajBXbXFXNHBn?=
 =?utf-8?B?Q1RDY1BQcDlUeFRkQnZhODljUWU5aUFRQXRZTTJ3aGwwYUxkNG40WHpWcTVx?=
 =?utf-8?B?SnlGMnpMTmpXSHVwTThkSC9nR0FUMUtPMXpPN0J2LyttcktKSmtFQkZpZ2JT?=
 =?utf-8?B?SDJ5blovWThLT1Qvd05pK3hCTVBqQ3lxWnBSemdYTU9ZMjZHSFR4K1FNb3or?=
 =?utf-8?B?RzdPanZGUnZvSXBxb3UyaDlzbld1YngxN2tiSmpOZGMrdFhJNFpvaEY0Rzlt?=
 =?utf-8?B?bk9GdkJxY3VmQlVDbDBxWWl4TDZvVWlOc2taSG1Ra3h3U2F6dnh3WitBQnVw?=
 =?utf-8?B?WHd6aDJwc25iUjFnaFozSnlOWXhlTzAvV1paUEJoQ1A1OVFBQk1yaFRXL1c4?=
 =?utf-8?B?NW9SQ2gzdnZyR2IzdHE1U2tJM2xCTkNMZVdLdDkrWHMxZnJpUXk2eEE2WjR0?=
 =?utf-8?B?T3I5aFJwbEF0ZzIxYVJJSUtaK1RVRE9KWVpORkl1eXRMcTJxQ3lwTDAvOTJq?=
 =?utf-8?B?MWpxQjk3U0hLcmlGUW02cUtmdUVwU01Ed2FSMG9JRm9DYnpCUzlkNlBKdmFZ?=
 =?utf-8?B?blp1UkFEZStQeXF0SG5MZ1dJR0h1NVJkS1YwcW9rS1NxSVdleVU0SzFCdS9v?=
 =?utf-8?B?ODBIQnhvK0xXak9qbXBIZ0FJWGRrVktzZUJLQkFTRVZaZEVyTElUNjJ2KzJs?=
 =?utf-8?B?NW5YQzBrVWhZZWh6eDRrMXFWZGJvbE5DTVRBaUp5VTZmMllnVWZVdHJiZHBU?=
 =?utf-8?B?bW8zekVxcUovc0tBd2IrcHBZY0pSNzU3ZGlYU0QxOXVGMEJmNnZFejdXZzRk?=
 =?utf-8?B?Y3ZHT0NEdnVRMksxSGNQNmI2cm5jbGx5aGZaYmZab3hFN29sNkpNZWdmNmJO?=
 =?utf-8?B?anFKblhrM3FhREhnNDQ4cGt2cGZFRkxDR25keFBPVXVQTStheit1QSsxWTNl?=
 =?utf-8?B?YTgzbWxsOU9ZZjIzMUN6eE5uUHZRUXc9PQ==?=
X-Microsoft-Antispam-Message-Info: uW0KE6m4MJ2dLwPSnND8Q2atejibrO1Wf5IYGU24UctvZbcg8egoDcKNStPuPUvfza6cvutkwDKOkGmHzWTjbO9CJGXvj9lghz5HXxYf1rEKpvYN+IjG01vrUD5MQZpvLlMVZeVXe8TwYlBgxn8XldQ8gi25vcW1WX+yYlbnsY1b+23UNALJ9dYFydxqX1bxKYDi2j9R4YOjHEjWMb5l65U7nOtRj/WPbaDm/iGjCtCJpAXUzjHWiH8cdFVHGY73XkyFDD1aEdI2ynMmZt9HBf+JdHYb2vYfmmj0gJuEl1f/E4Mpyew1/yWY9LGIUzb+c2TMLvoXH0Lf/SCBJuqDVVLWsYDYRO3aZfn/THxlULg=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;6:ECmvSJWSD68THYZL9W3o07IxmVetp7w/4mMTd8YhBNNb28kInT3L8K7S67v+bLnoiFvVE+orHc9/7DnHYxgVlTZ1fh/kIPzUDt3+XdHOLna/WFIkqhRdQ2v0s9MALLvg2t7XrLFazd4QI3lw2F7+qXrqDgpea8aT9KLv2clDpu0t318WaPc9preAR+/w9qEdM0G+SyYPA1n7i/8IKX4GS2o6Z8qeMStQQ0llEluy5FTwLUrrx5HFBA3FjbOKYk0a34gLWMCpkkti2k+raABGEJrfUPQN5QYWRJEymNsJRXp+MV1YVGjBs1TrvOfxWs2pQ4Qry/KzQUfHVVaqk5a1zTX1BOj5s6S3fezi/9EnJBMxFr82hrmefSnes3/Bt+zmHHKJTtWbbnBbK4PiFtPHEmO+ySrOLyjYL63GDME1dFJzANATWzq06Swq4AjXw4KbWsbnBZgtsZJ4z72srJMcZQ==;5:lH7SddAZhMzCWUDKzUzbcMNskBSsIQ55ozux87A7gNkZYMhDi3lU5IJEh7NAn3+9sKu4pK2h+TS620/OGiACGbOChGylRydFutAmvl3Sd1lCYKSd/iaz8N89I1sfTQ/mCbGyQkTC9ub9zGi3LAsM2s20g9vekAhSq+m3wZauPUc=;7:wY8pClnK5IvnfOpSIfbG9ul9VKfjJ8vfaPm439vl2QOoDKhf+jyEiLIuppLVH5lzbXwfEV8J+4FtwnEJS9b6bHEs3eeZOwTWkBULc7wAhba0VEJ27Cs/xxr5Zn/1M88ReeM+edpuokroN6Ftfu0HcIIs/6FCnMsZTcZCmoxDrHn+oXLpmKT+roLunkuIdaZDSoWw4Hq037Z2KVrfiVBCXd4E7mm5h4lGnMJOeJ8+2vvKqUmwmuVtAcEJXWQVmt7k
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 10:39:40.9406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ab4ace-227d-4eae-9399-08d5ee2d19dd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-20 12:05, Boris Brezillon wrote:
> On Fri, 20 Jul 2018 11:57:56 +0200 Peter Rosin <peda@axentia.se> wrote:
>> Maybe a bit-bang I3C master isn't feasible for some fundamental
>> reason?
> 
> No, it's clearly not. The way an I3C master is supposed to switch from
> open-drain to push-pull during a transaction or the concept of IBIs
> are the first things that come to mind, but I guess you have plenty of
> other reasons preventing you from implementing a i3c-bit-bang master.

Why can't a bit-banger switch from open-drain to push-pull? That's just
a matter of disconnecting some pull-ups, no? And maybe you know that no
device on your bus uses IBIs? Maybe none of reasons for why bit-banging
isn't feasible are applicable?

I.e. maybe there can be a I3C bit-banger that perhaps isn't generic and
isn't full-featured, but does work just fine in some specific setup?

Cheers,
Peter

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbeBDNJM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 08:09:12 -0500
Received: from mail-sn1nam01on0074.outbound.protection.outlook.com ([104.47.32.74]:60790
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751594AbeBDNJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 08:09:03 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] lightnvm: pblk: refactor bad block identification
Thread-Topic: [PATCH 5/5] lightnvm: pblk: refactor bad block identification
Thread-Index: AQHTmjgzfFIfrni0bUC6szzPt5VlUKONrQcAgAAGGcOAAJnagIAFxvOAgAAmWQCAAAPuyQ==
Date: Sun, 4 Feb 2018 13:09:00 +0000
Message-ID: <CBBD681B-B852-487F-B38D-6F405DBCB2E8@cnexlabs.com>
References: <1517364411-22386-1-git-send-email-javier@cnexlabs.com>
 <1517364411-22386-5-git-send-email-javier@cnexlabs.com>
 <bdde0655-0904-0bf1-7029-51708fcff8b3@lightnvm.io>
 <F1AA3AA6-8F23-43A8-9C4C-5F684A80782C@cnexlabs.com>
 <33896b20-c555-7c60-ed47-28156f4c93bf@lightnvm.io>
 <DEB69E27-635B-4B4F-ABA4-08BEC14B291F@cnexlabs.com>,<71151484-9bee-512b-cfe4-dd5bdc1b4711@lightnvm.io>
In-Reply-To: <71151484-9bee-512b-cfe4-dd5bdc1b4711@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [80.163.36.44]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB2770;7:uXWPky9llvAP+eVCa9BeyiZMFSDHMJW1Mu4YESXhsFMpXmnA+NsPgzgE/4v7Gc4znWJbCtiNicu0e9fQeMTsfmJyupLAEhsL6S6D99shOMYTBwpXWVjhEH10bz+ms6bZIeyqS4DBeDS/ToBKNqLxNekxbXN2CGxXfXHn6vzgfbIRu1mV89PM1E41J7xBD/VMwqJawuXJuqhwhHI+VNswFZ1G6P/YT68pXW+z/Cl+kWD1tTDYXwgHBNjfkfiKzqvW
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: d589025d-9817-4238-4262-08d56bd074f0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:BN6PR06MB2770;
x-ms-traffictypediagnostic: BN6PR06MB2770:
x-microsoft-antispam-prvs: <BN6PR06MB277060F382B06C60001C4830BAFF0@BN6PR06MB2770.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231101)(2400082)(944501161)(3002001)(10201501046)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR06MB2770;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB2770;
x-forefront-prvs: 05739BA1B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39380400002)(396003)(39830400003)(51414003)(199004)(189003)(36756003)(6506007)(3280700002)(77096007)(229853002)(3846002)(53936002)(53546011)(6116002)(6246003)(2906002)(6436002)(82746002)(4326008)(5660300001)(25786009)(83716003)(14454004)(86362001)(97736004)(966005)(478600001)(6486002)(316002)(81156014)(6916009)(81166006)(8676002)(2950100002)(106356001)(68736007)(105586002)(2900100001)(93886005)(33656002)(186003)(3660700001)(26005)(66066001)(7736002)(305945005)(8936002)(76176011)(6306002)(6512007)(102836004)(99286004)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB2770;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 2ttg7meRXDjHGdgU0gJAlIWDoCvwCip5/DR8NrMrWSlMLrraMi1RlCWtpgjjXYCUwiORXRjH8HKq3JgUJ3K5vw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d589025d-9817-4238-4262-08d56bd074f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2018 13:09:00.1596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB2770
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w14D9IH1026348


> On 4 Feb 2018, at 13.55, Matias Bjørling <mb@lightnvm.io> wrote:
> 
> On 02/04/2018 11:37 AM, Javier Gonzalez wrote:
>>> On 31 Jan 2018, at 19.24, Matias Bjørling <mb@lightnvm.io> wrote:
>>> 
>>> On 01/31/2018 10:13 AM, Javier Gonzalez wrote:
>>>>> On 31 Jan 2018, at 16.51, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>> 
>>>> I have a patches abstracting this, which I think it makes it cleaner. I can push it next week for review. I’m traveling this week. (If you want to get a glimpse I can point you to the code).
>>> 
>>> Yes, please do. Thanks
>> This is the release candidate for 2.0 support based on 4.17. I'll rebase
>> on top of you 2.0 support. We'll see if all changes make it to 4.17
>> then.
>> https://github.com/OpenChannelSSD/linux/tree/for-4.17/spec20
>> Javier
> 
> Great. I look forward to be patches being cleaned up and posted. I do see some nitpicks here and there, which we properly can take a couple of stabs at.

Sure. This is still in development; just wanted to point to the abstractions I’m thinking of so that we don’t do the same work twice. 

I’ll wait for posting until you do the 2.0 identify, since the old version is implemented on the first patch of this series. 

> One think that generally stands out to me is the "if 1.2 support", else, ... statements. These could be structured better by having dedicated setup functions for 1.2 and 2.0.

We have this construction both in pblk and in core for address translation. Note that we need to have them separated to support multi instance and keep channels decoupled from each instance. 

I assume 2 if...then is cheaper than doing 2 de-references to function pointers. This is the way it is done on legacy paths in other places (e.g., non mq scsi), but I can look into how pointer functions would look like and measure the performance impact. 

Javier

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756141AbeDXLXS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:23:18 -0400
Received: from mail-by2nam03on0075.outbound.protection.outlook.com ([104.47.42.75]:26934
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752831AbeDXLXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:23:15 -0400
From: "Kalluru, Sudarsana" <Sudarsana.Kalluru@cavium.com>
To: Florian Fainelli <f.fainelli@gmail.com>,
        Sebastian Kuzminsky <seb.kuzminsky@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Elior, Ariel" <Ariel.Elior@cavium.com>,
        Dept-Eng Everest Linux L2 <Dept-EngEverestLinuxL2@cavium.com>
Subject: RE: fix for bnx2x panic during ethtool reporting
Thread-Topic: fix for bnx2x panic during ethtool reporting
Thread-Index: AQHT1qXC/yzXSucE9USWZ8vdP5nfg6QPz5OQ
Date: Tue, 24 Apr 2018 11:23:12 +0000
Message-ID: <MW2PR07MB4139D11DC60825A8A6C04E068A880@MW2PR07MB4139.namprd07.prod.outlook.com>
References: <CAOTh5U2NwGU68cwzX2amhzPyj_=f0pm4CO4biR4m1DX49MJkUw@mail.gmail.com>
 <7747689b-6774-ca84-e0d5-ffd9b0d59e1b@gmail.com>
In-Reply-To: <7747689b-6774-ca84-e0d5-ffd9b0d59e1b@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sudarsana.Kalluru@cavium.com;
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR07MB4121;7:FUqL/vsDoTgvJg2DnYIhEp/GMn+jRhakSaw/7NDgAuD+h5mshd/nO0huLQRldWZ50lYXiTdYnKOC5R0c7MqwuET6OQe4l6nAQ/8duGuFdnl15w30QOFZMQMeuVMio9d79450fa+ViE0P+hAFJGkG+g6XPMtn5eWYFd486/h7ZzeQHdrty7bnzYHgJTyf8GDtTIy3ah2tbIgpFt58O2X/c8OY34+ZKd0L1BL5e5lPWbHXqsElbNOEsSQCJrczwPrt
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MW2PR07MB4121;
x-ms-traffictypediagnostic: MW2PR07MB4121:
x-microsoft-antispam-prvs: <MW2PR07MB4121E3A86E6501665D87F0718A880@MW2PR07MB4121.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(211171220733660);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231232)(944501410)(52105095)(3002001)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR07MB4121;BCL:0;PCL:0;RULEID:;SRVR:MW2PR07MB4121;
x-forefront-prvs: 0652EA5565
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39380400002)(396003)(39850400004)(366004)(189003)(199004)(13464003)(6436002)(9686003)(5250100002)(55016002)(5890100001)(2501003)(6246003)(81156014)(81166006)(53936002)(97736004)(8936002)(7696005)(229853002)(66066001)(74316002)(53546011)(6506007)(39060400002)(8676002)(76176011)(2900100001)(106356001)(305945005)(7736002)(68736007)(6636002)(33656002)(486006)(14454004)(110136005)(102836004)(2201001)(26005)(2906002)(186003)(86362001)(99286004)(316002)(6116002)(478600001)(3846002)(72206003)(476003)(25786009)(105586002)(3280700002)(446003)(11346002)(5660300001)(3660700001);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR07MB4121;H:MW2PR07MB4139.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: tFC/ut4+Larn5AdPWBDUpWMfC1rVBOT+ewlWLnn0vaqOhPH+I6L7kLCbQfNyqynU9xIcEbvot02EaapvELxJec1//kltETdT9RGJVf64liFxNlO43E2qWkj0sKRXBByZto1UaB2niYtnAeWVy3cjcujjT/p6eu56z+/FrMpTjK4XlAZArVULoE9jTUD8gezY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7ee3b6f1-3f0b-4f94-8ef2-08d5a9d5c424
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee3b6f1-3f0b-4f94-8ef2-08d5a9d5c424
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2018 11:23:12.1495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB4121
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3OBNNWm027776

-----Original Message-----
From: Florian Fainelli [mailto:f.fainelli@gmail.com] 
Sent: 18 April 2018 05:12
To: Sebastian Kuzminsky <seb.kuzminsky@gmail.com>; linux-kernel@vger.kernel.org; netdev@vger.kernel.org; Elior, Ariel <Ariel.Elior@cavium.com>; Dept-Eng Everest Linux L2 <Dept-EngEverestLinuxL2@cavium.com>
Subject: Re: fix for bnx2x panic during ethtool reporting

+netdev, Ariel,

On 04/17/2018 10:21 AM, Sebastian Kuzminsky wrote:
> "ethtool -i" on a bnx2x interface causes kernel panic when the 
> firmware version is longer than expected.  The attached patch fixes 
> the problem by simplifying the string handling in bnx2x_fill_fw_str().
> It applies cleanly to 4.14 and 4.17-rc1.

If you want to have a chance of getting your patch included, your should make sure you copy the driver maintainers and the network mailinglist, doing that.
--
Florian

Acked-by: Sudarsana Kalluru <Sudarsana.Kalluru@cavium.com>

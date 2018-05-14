Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbeENIHr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:07:47 -0400
Received: from mail-db5eur01on0077.outbound.protection.outlook.com ([104.47.2.77]:65238
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751941AbeENIHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:07:44 -0400
From: Samarth Parikh <Samarth.Parikh@arm.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Arvind Chauhan <Arvind.Chauhan@arm.com>,
        "samarthp@ymail.com" <samarthp@ymail.com>,
        Deepak Pandey <Deepak.Pandey@arm.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>
Subject: Re: [PATCH] mailbox: arm_mhu: add support for mhuv2
Thread-Topic: [PATCH] mailbox: arm_mhu: add support for mhuv2
Thread-Index: AQHT4eVPQJOcUiD4dEqNXHokADsBGqQcV5mAgBL2JgA=
Date: Mon, 14 May 2018 08:07:39 +0000
Message-ID: <FDE42FCD-8E61-4EE5-8893-6A9E7E7D64AC@arm.com>
References: <1525245244-15336-1-git-send-email-samarth.parikh@arm.com>
 <CABb+yY00AJ3ZBAU3R-=eaLJfBooY23JAiPaYxi=8MdCczKmZHw@mail.gmail.com>
In-Reply-To: <CABb+yY00AJ3ZBAU3R-=eaLJfBooY23JAiPaYxi=8MdCczKmZHw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Samarth.Parikh@arm.com;
x-originating-ip: [217.140.105.40]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0801MB1364;7:D5X8f5CCbZDW54EvCb0OUmWR7mC+Wo1nmzoCj4yoHo/eHAXdBk91fa7jH5e57py6yLLiiwW4XdCsLByVF2V15VZOZ8WoDpeO0rKeW6Av437My5uVG7BjQCP9QyGdfvAsLwnFKEgnsSDycRzive8/uaQFG3ELXqyTtwOawneOtJjPtZRCTgMwCYbC/v478cIplTWL/aSt5+vOWI3+WUt3RTDnIprWATvuCkb1IysbZXJlDxcuRO9pfZHyhOdz3KmJ
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1364;
x-ms-traffictypediagnostic: AM5PR0801MB1364:
x-microsoft-antispam-prvs: <AM5PR0801MB13642F3082D5B79C9D4AA1829C9C0@AM5PR0801MB1364.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM5PR0801MB1364;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1364;
x-forefront-prvs: 067270ECAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(39850400004)(396003)(346002)(376002)(199004)(189003)(40434004)(81166006)(83716003)(6486002)(105586002)(6436002)(3846002)(106356001)(6116002)(86362001)(82746002)(5250100002)(8936002)(36756003)(15650500001)(76176011)(486006)(81156014)(14454004)(11346002)(5890100001)(68736007)(4326008)(2616005)(478600001)(5660300001)(476003)(99286004)(3660700001)(305945005)(25786009)(186003)(8676002)(446003)(39060400002)(66066001)(72206003)(7736002)(53546011)(6506007)(59450400001)(6246003)(6512007)(33656002)(2900100001)(1411001)(6916009)(3280700002)(54906003)(26005)(316002)(2906002)(229853002)(102836004)(97736004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1364;H:AM5PR0801MB1250.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: e5Omhb+o0DfeMvTahCWFTVbEZozz6OsjkTk4GvbQ1UI+FuyF1nfH4x3zztky61zPtoOXSX/y9JjMEcz+LbzyGOO+86YrXXJZkB3D4aLtten0cxAE3aflu75kMM/3SI28v2ICcemZl2X+L0rkAMc/QrO6uO21Xe0nz4eTAafY4CCgMAO2jIMc+2Galf9b1eSk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C87BE056CAF6049BFEF94DEE845069B@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8acffd5d-8301-4a37-4867-08d5b971c33f
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acffd5d-8301-4a37-4867-08d5b971c33f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2018 08:07:40.0159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1364
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4E87sam008433

Hi Jassi,

As suggested by you, I have moved the MHUv2 related changes to a new file arm_mhu_v2.c. I have sent an updated patch, can you please review it?

Regards,
Samarth

﻿On 02/05/18, 5:34 PM, "Jassi Brar" <jassisinghbrar@gmail.com> wrote:

    On Wed, May 2, 2018 at 12:44 PM, Samarth Parikh <samarth.parikh@arm.com> wrote:
    > Hi Jassi,
    >
    > I am resending the patch for review, in case you have missed my previous
    > patch. Can you please go through it and let me know your thoughts on
    > the same?
    >
    You don't want this to go into git log :)
    If your patch isn't looked into for more than 2weeks (or longer if
    merge window is not near), please just ping as a reply to original
    submission.
    Anyways....

    > ARM has launched a next version of MHU i.e. MHUv2 with its latest
    > subsystems. The main change is that the MHUv2 is now a distributed IP
    > with different peripheral views (registers) for the sender and receiver.
    >
    > Another main difference is that MHUv1 duplex channels are now split into
    > simplex/half duplex in MHUv2. MHUv2 has a configurable number of
    > communication channels. There is a capability register (MSG_NO_CAP) to
    > find out how many channels are available in a system.
    >
    > The register offsets have also changed for STAT, SET & CLEAR registers
    > from 0x0, 0x8 & 0x10 in MHUv1 to 0x0, 0xC & 0x8 in MHUv2 respectively.
    >
    > 0x0    0x4  0x8  0xC             0x1F
    > ------------------------....-----
    > | STAT |    |    | SET |    |   |
    > ------------------------....-----
    >       Transmit Channel
    >
    > 0x0    0x4  0x8   0xC            0x1F
    > ------------------------....-----
    > | STAT |    | CLR |    |    |   |
    > ------------------------....-----
    >         Receive Channel
    >
    > The MHU controller can request the receiver to wake-up and once the
    > request is removed, the receiver may go back to sleep, but the MHU
    > itself does not actively puts a receiver to sleep.
    >
    > So, in order to wake-up the receiver when the sender wants to send data,
    > the sender has to set ACCESS_REQUEST register first in order to wake-up
    > receiver, state of which can be detected using ACCESS_READY register.
    > ACCESS_REQUEST has an offset of 0xF88 & ACCESS_READY has an offset
    > of 0xF8C and are accessible only on any sender channel.
    >
    > This patch adds necessary changes required to support the older
    > version of MHU & the latest MHUv2 controller. This patch also need an
    > update in DT binding for ARM MHU as we need a second register base
    > (tx base) which would be used as the send channel base.
    >
    > Signed-off-by: Samarth Parikh <samarth.parikh@arm.com>
    > ---
    >  drivers/mailbox/arm_mhu.c | 163 ++++++++++++++++++++++++++++++++++++++++++----
    >  1 file changed, 151 insertions(+), 12 deletions(-)
    >
    The original driver is 195 loc, this patch makes it almost double the size.
    Also there have been controllers (resembling closer to MHU than this
    one) with separate drivers. So I think we should simply create another
    arm_mhu_v2.c ?

    Cheers!


IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

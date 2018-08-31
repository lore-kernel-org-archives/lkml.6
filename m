Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95277C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3531D2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gmn54iCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3531D2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbeHaTuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:50:11 -0400
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:9393
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728437AbeHaTuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69iFKQDHoNzvp7m8uEqYbtfPrQo2q7Mld+M015i8cSI=;
 b=gmn54iCxi3NRcP0mRhfs6ZeBFkHDvrsgUJTPw3LgXUp93n3wA83Ec9nUfz+FoLVancdXfe+M1z+4Uwv5/D6IP5exqiPZlrEftqTBocnL+fb1qBUsUl+WBxXBpznssiH7LP8l4R+e6qtbSIsolIVmfzhJ9GHuLG0XL7BmmsnHZBs=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Fri, 31 Aug 2018 15:42:00 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c%4]) with mapi id 15.20.1143.000; Fri, 31 Aug 2018
 15:42:00 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH v2 1/4] arm64: hyperv: Add core Hyper-V include files
Thread-Topic: [PATCH v2 1/4] arm64: hyperv: Add core Hyper-V include files
Thread-Index: AQHUP68OmssN12FiZkKavIoXOEJyl6TYnbcAgAFYyCA=
Date:   Fri, 31 Aug 2018 15:42:00 +0000
Message-ID: <CY4PR21MB077332AF1772688B50917301DC0F0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <1535556148-10452-1-git-send-email-mikelley@microsoft.com>
 <1535556148-10452-2-git-send-email-mikelley@microsoft.com>
 <MW2PR2101MB1113C65A74A961624C865B8CA0080@MW2PR2101MB1113.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB1113C65A74A961624C865B8CA0080@MW2PR2101MB1113.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-08-31T15:41:58.0231502Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:ifLJV6/GFRRPI4wFceEthJz6h8hpmzeKtqMfmNBIrclZE33cia7A+xHfbdTsy9rgv4R8kIM5u67W27krByatIMqT1AZKuKRiXqezCccM+u+SyKfQvBGf77K7HiGGItJ5mdzF6GNJYR8ggSexpP4qVnjlw7U9AlHMMoy8aZhrhYJPzKHwwcALQnNDnc024KZKA6C145hyhnMSYvZngTPQRO8TZhBmz1barhP0+AZTTrvSaIQsmc7mW+pk5aIqyEO6e1egkbaZCZvOF5Fgw479Qrqpf1ybkGS+kThZwBCoegQoWVnMUV8MMb1lm2D8THNbNwQ0eRG6Jhi8SFtHnexBRsKr7xz9G2cmw0Lb3X90s9kD7CbUSh+DYmo9KAWCpGbFkyqA37t/RwqptSD5ZRA1h1ZZZazBmkguzt1kB69N/Jy5ekT4PAhx2FRtMHKopeFna77Nbvw9gtM4vaHenwNCVQ==;5:MdwjZVORaPI9oj6JGBdMpcIYEhhu5lIuhQMX5Yen2U4oX8RuC0XBd5ttkSBKUroA9T2yGAuvHwQOl6xg68ZLhCTolQbVtkEP48mNAWlge6I/ZUsLRoJJ1yz8d2ZHOcO31v+z2I5D5+dR2vOUmQ5IQzdx88X74p80SsRTEx5egAo=;7:knBhSSmDc5ev1TXHUcO+5D2BdOVgFOcd7TklZNSEMJ6cPxzpsFDLYKFQs8xMhBwA8yZE66ZTDDcLOAlAGpHT53W3LcR2FZh9JDdz5JAcBdd5JM4JEchFizNrYl6os2wVGMuaeQmyaONdsUKGJ4dGMWGEBmIZoqyGJdTW/0AjcawdHNd4Ypl20NDcMQe40toF4ajUlDC3kJHi3b84Ku/AACoUUFnFRhgQIVnpolYp+5lr2CL5n2XbkAQTr7NtnRn9
x-ms-office365-filtering-correlation-id: 7f384f1e-c6f4-45fe-e64c-08d60f584ac5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB07410A4FA36697E6807791A3DC0F0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(176295241369792);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 07817FCC2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(396003)(39860400002)(189003)(199004)(86612001)(102836004)(72206003)(8990500004)(99286004)(106356001)(2201001)(86362001)(575784001)(105586002)(97736004)(2900100001)(6506007)(10290500003)(229853002)(66066001)(1511001)(22452003)(2501003)(76176011)(7696005)(8676002)(53936002)(478600001)(68736007)(5250100002)(81166006)(45954006)(81156014)(8936002)(33656002)(2906002)(6636002)(74316002)(19627235002)(316002)(55016002)(486006)(7416002)(25786009)(11346002)(446003)(476003)(3846002)(6116002)(9686003)(256004)(10090500001)(305945005)(110136005)(14454004)(7736002)(6306002)(6436002)(26005)(14444005)(5660300001)(6246003)(966005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 434lQxpBcedV3I4MC+ZTXRWzx4szqPgM3XXQvG0yFc4OrOGql0Bt36sLnp9wtiz0X349soAAufHe8vyd+RzLwYh4NLyeGU/GXubBV4v8bSXiAVlhLgwim2Aco0Lh6U/FY6TqKyHacC3iJ+o34wSSFHe1u2FWq//RoXPmRXUjcoLpmR6CkpwdUqWgkfCwMuJSTjPsm/kg87DgIAPES/rPnrgQq8gt4DlVj2dotFz4YdRJ1/thV0nY72iASyZwtMM+NJZqGFIij+TtIhOSynThUxCXdycvPk22Yj9tm6hYXMSmjhO+ZRqEehBj7SFCm1f4+//SYyzT5G7RvvS2Qqiu7cCoQ1OxHcZwwV7OCnVHKtA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f384f1e-c6f4-45fe-e64c-08d60f584ac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2018 15:42:00.3494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KY Srinivasan Sent: Thursday, August 30, 2018 11:23 AM

> > +/*
> > + * This file contains definitions from the Hyper-V Hypervisor Top-Leve=
l
> > + * Functional Specification (TLFS):
> > + * https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/=
reference/tlfs
> > +
> A lot of TLFS definitions are ISA independent and we are duplicating thes=
e
> definitions both for X86_64 and ARM_64.  Perhaps we should look at splitt=
ing
> this file into a common and ISA specific header file.

I agree that we want to end up with x86_64 and ARM64 ISA dependent files
that include an ISA independent file.  My thinking was to not make that
separation now, for a couple of reasons:

1) We don't have a Hyper-V TLFS that is explicit about what should be
considered ISA independent and ISA dependent.  I can make some
reasonable guesses, but it will be subject to change as the Hyper-V team
firms up the interface and decides what they want to commit to.

2) Some of the things defined in the TLFS have names that are
x86-specific (TSC, MSR, etc.).  For the ISA independent parts, those names
should be more generic, which is another dependency on the Hyper-V
team defining the ISA independent parts of the TLFS.

My judgment was that we'll end up with less perturbation overall to go
with this cloned version of hyperv-tlfs.h for now, and then come back
and do the separation once we have a definitive TLFS to base it on.  But
it's a judgment call, and if the sense is that we should do the separation
now, I can give it a try.

> > +#define HvRegisterHypervisorVersion0x00000100 /*CPUID
> > 0x40000002 */
> > +#defineHvRegisterPrivilegesAndFeaturesInfo0x00000200 /*CPUID
> > 0x40000003 */
> > +#defineHvRegisterFeaturesInfo0x00000201
> > /*CPUID 0x40000004 */
> > +#defineHvRegisterImplementationLimitsInfo0x00000202 /*CPUID
> > 0x40000005 */
> > +#define HvARM64RegisterInterfaceVersion0x00090006 /*CPUID
> > 0x40000001 */
>=20
> Can we avoid the mixed case names.

Agreed. I'll fix this throughout to use all uppercase, with underscore
as the word separator.

> > + * Linux-specific definitions for managing interactions with Microsoft=
's
> > + * Hyper-V hypervisor. Definitions that are specified in the Hyper-V
> > + * Top Level Functional Spec (TLFS) should not go in this file, but
> > + * should instead go in hyperv-tlfs.h.
>=20
> Would it make sense to breakup this header file into ISA independent and =
dependent files?

Yes, as above I agree the separation make sense.  And since this file is ti=
ed
To Linux and not to the Hyper-V TLFS, the separation isn't affected by the
TLFS issues mentioned above.  I'll give it a try and see if any issues aris=
e.

> > +/*
> > + * Define the IRQ numbers/vectors used by Hyper-V VMbus interrupts
> > + * and by STIMER0 Direct Mode interrupts. Hyper-V should be supplying
> > + * these values through ACPI, but there are no other interrupting
> > + * devices in a Hyper-V VM on ARM64, so it's OK to hard code for now.
> > + * The "CALLBACK_VECTOR" terminology is a left-over from the x86/x64
> > + * world that is used in architecture independent Hyper-V code.
> > + */
> When we have direct device assignment for ARM-64 guests, can we still har=
dcode.

Yes, we can still hardcode.  These values are in the Per-Processor Interrup=
t
(PPI) range of 16 to 31.  Any IRQ numbers assigned to a Discrete Device
Assignment (DDA) device will be in the Shared Peripheral Interrupt (SPI)
range of 32-1019 or the Locality-specific Peripheral Interrupt (LPI) range
of greater than 8192.   The handling of DDA interrupts is still under
discussion with the Hyper-V team, but there won't be any conflicts with
the PPI values that are hardcoded here.

> > +/*
> > + * The guest OS needs to register the guest ID with the hypervisor.
> > + * The guest ID is a 64 bit entity and the structure of this ID is
> > + * specified in the Hyper-V specification:
> > + *
> > + * msdn.microsoft.com/en-
> > us/library/windows/hardware/ff542653%28v=3Dvs.85%29.aspx
> > + *
> > + * While the current guideline does not specify how Linux guest ID(s)
> > + * need to be generated, our plan is to publish the guidelines for
> > + * Linux and other guest operating systems that currently are hosted
> > + * on Hyper-V. The implementation here conforms to this yet
> > + * unpublished guidelines.
> > + *
> > + *
> > + * Bit(s)
> > + * 63 - Indicates if the OS is Open Source or not; 1 is Open Source
> > + * 62:56 - Os Type; Linux is 0x100
> > + * 55:48 - Distro specific identification
> > + * 47:16 - Linux kernel version number
> > + * 15:0  - Distro specific identification
> > + *
> > + * Generate the guest ID based on the guideline described above.
> > + */
>=20
> No need to repeat the above block comment (already included in the TLFS h=
eader).

Agreed.  Will make the change in v3 of the patch.

> > +/* Free the message slot and signal end-of-message if required */
> > +static inline void vmbus_signal_eom(struct hv_message *msg, u32
> > old_msg_type)
> > +{
> > +/*
> > + * On crash we're reading some other CPU's message page and we
> > need
> > + * to be careful: this other CPU may already had cleared the header
> > + * and the host may already had delivered some other message
> > there.
> > + * In case we blindly write msg->header.message_type we're going
> > + * to lose it. We can still lose a message of the same type but
> > + * we count on the fact that there can only be one
> > + * CHANNELMSG_UNLOAD_RESPONSE and we don't care about
> > other messages
> > + * on crash.
> > + */
> > +if (cmpxchg(&msg->header.message_type, old_msg_type,
> > +    HVMSG_NONE) !=3D old_msg_type)
> > +return;
> > +
> > +/*
> > + * Make sure the write to MessageType (ie set to
> > + * HVMSG_NONE) happens before we read the
> > + * MessagePending and EOMing. Otherwise, the EOMing
> > + * will not deliver any more messages since there is
> > + * no empty slot
> > + */
> > +mb();
> > +
> > +if (msg->header.message_flags.msg_pending) {
> > +/*
> > + * This will cause message queue rescan to
> > + * possibly deliver another msg from the
> > + * hypervisor
> > + */
> > +hv_set_vpreg(HvRegisterEom, 0);
> > +}
> > +}
>=20
> The code above is identical to what we have on the x86 side except how we
> signal EOM state. If we abstract this, this entire function can be in a c=
ommon file.

Agreed.  I should be able to do that as part of breaking out
an ISA independent version of this include file.

Michael

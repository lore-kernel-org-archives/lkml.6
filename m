Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xRunAGV9HlsOVQAAmS7hNA
	; Mon, 11 Jun 2018 13:47:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9E746607E7; Mon, 11 Jun 2018 13:47:23 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="iYkA9UNX"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4914560792;
	Mon, 11 Jun 2018 13:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4914560792
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933331AbeFKNrU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 09:47:20 -0400
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:54513 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932904AbeFKNrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1528724736; x=1560260736;
  h=from:cc:to:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jukr7lK2rfYRnLQqHaMlwyXXo3X8HEnokIt+J8ZvpHQ=;
  b=iYkA9UNXOrBiAslBWKxZDYNtpwigARAPBQvTfVJblD5tdrtfy5I+ENMi
   TKMqYydHaBqEe52XIdL25f95ZbSD9VJvtv+OLZEihNVu+v0IOXXtT+KYe
   H9VSvnpXtzJhiHjQvLUraBU16fxRNpCFjkCwY/fte8jqaUtwA+q7A1ybE
   U=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GoAQAdfB5bh8uZ6ERcGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQXgQ0oCphVgX6IGIw7FIFkC4RsAoJgITUXAQIBAQEBAQECAQE?=
 =?us-ascii?q?CEAEBAQoLCQgpL4I1IoJTAQEBAQMnEzQLDAQCAQgRBAEBAR4JByElCQgCBAESC?=
 =?us-ascii?q?IMagWkDFaphM4cIDYEsgWiIRIITgQ+CXi6CT4FohhECh0SGE4p5LAcCiEqDIYJ?=
 =?us-ascii?q?7gUaDe4dvilGGYIFCAYIJcFCCQ4IeAw4JjhdvAY9OgRoBAQ?=
X-IPAS-Result: =?us-ascii?q?A2GoAQAdfB5bh8uZ6ERcGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?XgQ0oCphVgX6IGIw7FIFkC4RsAoJgITUXAQIBAQEBAQECAQECEAEBAQoLCQgpL?=
 =?us-ascii?q?4I1IoJTAQEBAQMnEzQLDAQCAQgRBAEBAR4JByElCQgCBAESCIMagWkDFaphM4c?=
 =?us-ascii?q?IDYEsgWiIRIITgQ+CXi6CT4FohhECh0SGE4p5LAcCiEqDIYJ7gUaDe4dvilGGY?=
 =?us-ascii?q?IFCAYIJcFCCQ4IeAw4JjhdvAY9OgRoBAQ?=
Received: from esa5.dell-outbound2.iphmx.com ([68.232.153.203])
  by esa3.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 08:45:36 -0500
From: <Mario.Limonciello@dell.com>
Cc: <stuart.w.hayes@gmail.com>, <Douglas.Warzecha@dell.com>,
        <Jared.Dominguez@dell.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
Received: from ausc60ps301.us.dell.com ([143.166.148.206])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 19:38:31 +0600
X-LoopCount0: from 10.166.132.40
X-IronPort-AV: E=Sophos;i="5.49,502,1520917200";
   d="scan'208";a="1168513748"
X-DLP: DLP_GlobalPCIDSS
To: <dvhart@infradead.org>, <andy.shevchenko@gmail.com>
Subject: RE: [PATCH resend v2] dcdbas: Add support for WSMT ACPI table
Thread-Topic: [PATCH resend v2] dcdbas: Add support for WSMT ACPI table
Thread-Index: AQHT/nimP1EmLCCn3E2XclfkbDCd/qRVXBSAgAIWZACAA6VbIA==
Date: Mon, 11 Jun 2018 13:47:15 +0000
Message-ID: <b9a262dd952d4ebca8fe70edba450c10@ausx13mpc120.AMER.DELL.COM>
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
 <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com>
 <CAHp75Vdmqm+r=Orxs6_dCr18y+EwEQ=s-7UgaZKHuKbtjMcOig@mail.gmail.com>
 <20180609010420.GA112645@localhost.localdomain>
In-Reply-To: <20180609010420.GA112645@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Friday, June 8, 2018 8:04 PM
> To: Andy Shevchenko
> Cc: Stuart Hayes; Warzecha, Douglas; Limonciello, Mario; Dominguez, Jared=
; Linux
> Kernel Mailing List; Platform Driver
> Subject: Re: [PATCH resend v2] dcdbas: Add support for WSMT ACPI table
>=20
> On Thu, Jun 07, 2018 at 08:11:41PM +0300, Andy Shevchenko wrote:
> > On Thu, Jun 7, 2018 at 6:59 PM, Stuart Hayes <stuart.w.hayes@gmail.com>
> wrote:
> > > If the WSMT ACPI table is present and indicates that a fixed communic=
ation
> > > buffer should be used, use the firmware-specified buffer instead of
> > > allocating a buffer in memory for communications between the dcdbas d=
river
> > > and firmare.
> >
> > >  config DCDBAS
> > >         tristate "Dell Systems Management Base Driver"
> > > -       depends on X86
> > > +       depends on X86 && ACPI
>=20
>=20
> >
> > Hmm... I'm not sure about this dependency.
> > So, the question is do all users actually need this? How did it work
> > previously? How has this been tested in case when command line has
> > "acpi=3Doff" (yes, this one just for sake of test, I don't believe it's
> > a real use case)?
>=20
> Yeah... after the 4.16 and 4.17 KConfig fumbling around the SMBIOS
> driver which intersected with this one.... this needs to be thoroughly
> covered, tested, and thought through. Linus was.... generous in the
> number of attempts it took us to get that right.
>=20
> Did DCDBAS ever work on a system without ACPI?

Yes, I would expect it would have functioned on a system with kernel's
ACPI disabled.  However I also agree this isn't a real use case with a mode=
rn
Machine.

Perhaps the right thing to do is
#ifdef CONFIG_ACPI

For the WSMT relevant items in this patch?

>=20
> >
> > >  #include <linux/string.h>
> > >  #include <linux/types.h>
> > >  #include <linux/mutex.h>
> > > +#include <linux/acpi.h>
> >
> > Please, try to keep an order as much as possible.
> > For example, in given context this line should be before string.h (I
> > didn't check the actual file, perhaps even upper).
> >
> > >  #include <asm/io.h>
> > >
> > >  #include "dcdbas.h"
> >
> > >                 /* Calling Interface SMI */
> > > -               smi_cmd->ebx =3D (u32) virt_to_phys(smi_cmd->command_=
buffer);
> > > +               smi_cmd->ebx =3D smi_data_buf_phys_addr
> > > +                               + offsetof(struct smi_cmd, command_bu=
ffer);
> >
> > Please, keep at least + on the previous line.
> > Also, I'm not sure what is the difference now. Especially for previous
> > users when this wasn't the part of the driver.
> > Some explanation needed.
> >
> > > +static u8 checksum(u8 *buffer, u8 length)
> > > +{
> > > +       u8 sum =3D 0;
> > > +       u8 *end =3D buffer + length;
> > > +
> > > +       while (buffer < end)
> > > +               sum =3D (u8)(sum + *(buffer++));
> >
> > Why not simple
> >
> > sum +=3D *buffer++;
> >
> > ?
> >
> > > +       return sum;
> > > +}
> >
> > And I would rather check if we have similar algoritms already in the
> > kernel which  we might re-use.
>=20
> Seems to be some options in lib/checksum.c to check.
>=20
> >
> > > +
> > > +static inline struct smm_eps_table *check_eps_table(u8 *addr)
> > > +{
> > > +       struct smm_eps_table *eps =3D (struct smm_eps_table *)addr;
> > > +
> >
> > > +       if (strncmp(SMM_EPS_SIG, eps->smm_comm_buff_anchor, 4) !=3D 0=
)
> >
> > I'm not sure about strings operation here.
> > I would rather do like with other magic constants: introduce hex value
> > and compare it as unsigned integer.
> >
> > Also, it might be a warning, since \0 wasn't ever checked from the
> > string literal. Though, I'm not sure if it applicable to strncmp()
> > function (it's for strncpy for sure).
>=20
> I think we're OK here, and we're being consistent with the
> dell-wmi-descriptor test for "DELL WMI". I don't recall if it was that
> one or something else, but doing it in HEX ended up being more
> confusing. The \0 isn't an issue since strncmp will only compare the n
> (4) bytes.
>=20
> >
> > > +               return NULL;
> > > +
> > > +       if (checksum(addr, eps->length) !=3D 0)
> > > +               return NULL;
> > > +
> > > +       return eps;
> > > +}
> > > +
> > > +static int dcdbas_check_wsmt(void)
> > > +{
> > > +       struct acpi_table_wsmt *wsmt =3D NULL;
> > > +       struct smm_eps_table *eps =3D NULL;
> > > +       u8 *addr;
> > > +
> > > +       acpi_get_table(ACPI_SIG_WSMT, 0, (struct acpi_table_header **=
)&wsmt);
> > > +       if (!wsmt)
> > > +               return 0;
> > > +
> > > +       /* Check if WSMT ACPI table shows that protection is enabled =
*/
> > > +       if (!(wsmt->protection_flags & ACPI_WSMT_FIXED_COMM_BUFFERS)
> > > +           || !(wsmt->protection_flags
> > > +                & ACPI_WSMT_COMM_BUFFER_NESTED_PTR_PROTECTION))
> > > +               return 0;
> > > +
> > > +       /* Scan for EPS (entry point structure) */
> > > +       for (addr =3D (u8 *)__va(0xf0000);
> > > +            addr < (u8 *)__va(0x100000 - sizeof(struct smm_eps_table=
)) && !eps;
> >
> > Perhaps better to do
> >
> > for (...) {
> >  eps =3D ...();
> >  if (eps)
> >   break;
> > }
> >
> > Also I've a feeling that 0xf0000 constant is defined already somewhere
> > under arch/x86/include/asm or evem include/linux.
>=20
> But... is it defined for this purpose? If not, I'd prefer it hardcoded
> (or with a DEFINE).
>=20
> >
> > > +            addr +=3D 1)
> >
> > +=3D 1?!
> > All tables I saw in BIOS are aligned with 16 bytes. Is it the case here=
?
> >
> > Is there any other means to check if the table present? ACPI code?
> > Method / variable?
> >
> > > +               eps =3D check_eps_table(addr);
> > > +
> > > +       if (!eps) {
> > > +               dev_dbg(&dcdbas_pdev->dev, "found WSMT, but no EPS fo=
und\n");
> > > +               return -ENODEV;
> > > +       }
> > > +
> > > +       /*
> > > +        * Get physical address of buffer and map to virtual address.
> > > +        * Table gives size in 4K pages, regardless of actual system =
page size.
> > > +        */
> >
> > > +       if (eps->smm_comm_buff_addr + 8 > U32_MAX) {
> >
> > if (upper_32_bits(..._addr + 8)) {
> >
> > ?
> >
> > > +               dev_warn(&dcdbas_pdev->dev, "found WSMT, but EPS buff=
er address
> is above 4GB\n");
> > > +               return -EINVAL;
> > > +       }
> > > +       eps_buffer =3D (u8 *)memremap(eps->smm_comm_buff_addr,
> >
> > Why casting?
> >
> > > +                                    eps->num_of_4k_pages * 4096, MEM=
REMAP_WB);
> >
> > This multiplication looks strange. Perhaps use PAGE_SIZE?
> >
> > > +       if (!eps_buffer) {
> > > +               dev_warn(&dcdbas_pdev->dev, "found WSMT, but failed t=
o map EPS
> buffer\n");
> > > +               return -ENOMEM;
> > > +       }
> > > +
> > > +       /* First 8 bytes of buffer is for semaphore */
> > > +       smi_data_buf_phys_addr =3D (u32) eps->smm_comm_buff_addr + 8;
> >
> > lower_32_bits() ?
> >
> > > +       smi_data_buf =3D eps_buffer + 8;
> >
> > > +       smi_data_buf_size =3D (unsigned long) min(eps->num_of_4k_page=
s * 4096 -
> 8,
> > > +                           (u64) ULONG_MAX);
> >
> > This is too twisted code. First, it needs explanation.
> > Second, it might need some refactoring.
> >
> > (Yes, I got the idea, but would it be better implementation?)
> >
> > > +       max_smi_data_buf_size =3D smi_data_buf_size;
> > > +       wsmt_enabled =3D true;
> > > +       dev_info(&dcdbas_pdev->dev,
> > > +                "WSMT found, using firmware-provided SMI buffer.\n")=
;
> > > +       return 1;
> > > +}
> >
> > >  #define SMI_CMD_MAGIC                          (0x534D4931)
> > >
> > > +#define SMM_EPS_SIG                            "$SCB"
> >
> > Just integer like above and put the sting as a comment.
> > (Side note: above magic also looks like string)
>=20
> Given the above, I think we can use the more recognizable string - since
> that is clearly how they think of this label.
>=20
> Otherwise, agree with a follow-up to all of Andy's feedback.
>=20
> --
> Darren Hart
> VMware Open Source Technology Center

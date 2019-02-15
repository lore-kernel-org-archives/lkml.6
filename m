Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC0EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EDA2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbfBOCp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:45:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40816 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728509AbfBOCp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:45:56 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1F2i27R009636
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 21:45:55 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qnfed9vw7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 21:45:55 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 15 Feb 2019 02:45:52 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Feb 2019 02:45:48 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1F2jl9o19529894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Feb 2019 02:45:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3049BAE04D;
        Fri, 15 Feb 2019 02:45:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5642DAE051;
        Fri, 15 Feb 2019 02:45:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.92.50])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 15 Feb 2019 02:45:45 +0000 (GMT)
Subject: Re: [PATCH v3 1/2] ima: fix build error redeclaration of enumerator
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Anders Roxell <anders.roxell@linaro.org>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        ard.biesheuvel@linaro.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Feb 2019 21:45:34 -0500
In-Reply-To: <1550165329.3980.8.camel@linux.ibm.com>
References: <20190213221625.7551-1-anders.roxell@linaro.org>
         <1550165329.3980.8.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021502-0020-0000-0000-00000317017F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021502-0021-0000-0000-000021683302
Message-Id: <1550198734.4107.53.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902150017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-14 at 12:28 -0500, Mimi Zohar wrote:
> On Wed, 2019-02-13 at 23:16 +0100, Anders Roxell wrote:
> > Commit a893ea15d764 ("tpm: move tpm_chip definition to
> > include/linux/tpm.h") introduced a build error when both ima and efi is
> > enabled. What happens is that both headers (ima.h and efi.h) defines the
> > same 'NONE' constant, and it broke when they started getting included
> > from the same file.
> > 
> > In file included from ../security/integrity/ima/ima_fs.c:30:
> > ../security/integrity/ima/ima.h:176:7: error: redeclaration of enumerator "NONE"
> >   hook(NONE)   \
> >        ^~~~
> > ../security/integrity/ima/ima.h:188:34: note: in definition of macro "__ima_hook_enumify"
> >  #define __ima_hook_enumify(ENUM) ENUM,
> >                                   ^~~~
> > ../security/integrity/ima/ima.h:191:2: note: in expansion of macro "__ima_hooks"
> >   __ima_hooks(__ima_hook_enumify)
> >   ^~~~~~~~~~~
> > In file included from ../arch/arm64/include/asm/acpi.h:15,
> >                  from ../include/acpi/acpi_io.h:7,
> >                  from ../include/linux/acpi.h:47,
> >                  from ../include/linux/tpm.h:26,
> >                  from ../security/integrity/ima/ima.h:25,
> >                  from ../security/integrity/ima/ima_fs.c:30:
> > ../include/linux/efi.h:1723:2: note: previous definition of "NONE" was here
> >   NONE,
> >   ^~~~
> > make[4]: *** [../scripts/Makefile.build:277: security/integrity/ima/ima_fs.o] Error 1
> > 
> > Rework to prefix the ima enum with 'IMA_*'.
> > 
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> 
> Ok, this looks reasonable, but will have a minor clash with Gustavo's
> "security: mark expected switch fall-throughs and add a missing
> break".

This patch correctly didn't modify the IMA policy keywords, just the
enumeration, but now the <securityfs> policy file incorrectly displays
the "ima_" prefixed names.

Instead of maintaining an enumeration and the corresponding
stringified version of the enumeration, there is a single list with
two macros.  One of these macros needs to be modified.  Instead of
modifying the the hook names directly, I would probably modify the
enumeration macro.

#define __ima_hook_enumify(ENUM)        ENUM,

enum ima_hooks {
        __ima_hooks(__ima_hook_enumify)
};

and

#define __ima_hook_stringify(str)       (#str),

static const char *const func_tokens[] = {
        __ima_hooks(__ima_hook_stringify)
};

Mimi


Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69286C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34008206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbfAIOH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:07:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730543AbfAIOH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:07:58 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09E4FV4081883
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 09:07:58 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwhr8ab2a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 09:07:57 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 9 Jan 2019 14:07:55 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 14:07:50 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09E7mXN47448156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 14:07:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FD32AE063;
        Wed,  9 Jan 2019 14:07:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC7DFAE05F;
        Wed,  9 Jan 2019 14:07:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.106.104])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 14:07:46 +0000 (GMT)
Subject: Re: [RFC PATCH 1/1] KEYS, integrity: Link .platform keyring to
 .secondary_trusted_keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        ebiggers@google.com, nayna@linux.ibm.com,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        kexec@lists.infradead.org
Date:   Wed, 09 Jan 2019 09:07:36 -0500
In-Reply-To: <20190109013356.GA2610@dhcp-128-65.nay.redhat.com>
References: <20190108081247.2266-1-kasong@redhat.com>
         <20190108081247.2266-2-kasong@redhat.com>
         <1546960680.19931.114.camel@linux.ibm.com>
         <20190109013356.GA2610@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010914-0008-0000-0000-000002AE5E88
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010914-0009-0000-0000-0000221A60A4
Message-Id: <1547042856.19931.229.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-09 at 09:33 +0800, Dave Young wrote:
> CC kexec list
> On 01/08/19 at 10:18am, Mimi Zohar wrote:
> > [Cc'ing the LSM and integrity mailing lists]
> > 
> > Repeating my comment on PATCH 0/1 here with the expanded set of
> > mailing lists.
> > 
> > The builtin and secondary keyrings have a signature change of trust
> > rooted in the signed kernel image.  Adding the pre-boot keys to the
> > secondary keyring breaks that signature chain of trust.
> > 
> > Please do NOT add the pre-boot "platform" keys to the secondary
> > keyring.
> 
> If we regard kexec as a bootloader, it sounds natural to use the
> platform key to verify the signature with kexec_file_load syscall.
> 
> It will be hard for user to manually sign a kernel and import the key
> then to reuse kexec_file_load.

This is really a generic topic, not limited to kexec, which should be
discussed.  Let's defer this discussion for now.

> 
> I think we do not care if platform key can be added to secondary or not,
> any suggestions how can kexec_file to use the platform key?

I assume the problem is accessing the keyring id.

Instead of defining a function to return the keyring id, as below,
define a function that sets a variable with the keyring id.
 platform_keyring_init() would call that function to set the variable.

Similar to builtin_trusted_keys and secondary_trusted_keys, define a
variable named platform_trusted_keys.

[snip]

> > > diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> > > index f45d6edecf99..397758d4f12d 100644
> > > --- a/security/integrity/digsig.c
> > > +++ b/security/integrity/digsig.c
> > > @@ -176,3 +176,10 @@ int __init integrity_load_cert(const unsigned int id, const char *source,
> > >  	pr_info("Loading X.509 certificate: %s\n", source);
> > >  	return integrity_add_key(id, data, len, perm);
> > >  }
> > > +
> > > +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> > > +struct key* __init integrity_get_platform_keyring(void)
> > > +{
> > > +	return keyring[INTEGRITY_KEYRING_PLATFORM];
> > > +}
> > > +#endif

Mimi


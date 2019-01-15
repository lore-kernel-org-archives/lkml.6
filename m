Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13A0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5F020645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbfAOP4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:56:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728971AbfAOP4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:56:24 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0FFuLmO032717
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:56:23 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q1g50h0xe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:56:22 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 15 Jan 2019 15:55:08 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 15 Jan 2019 15:55:04 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0FFt29q4129064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 15:55:02 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76ADB42047;
        Tue, 15 Jan 2019 15:55:02 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 850D94203F;
        Tue, 15 Jan 2019 15:55:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.106.167])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Jan 2019 15:55:00 +0000 (GMT)
Subject: Re: [RFC PATCH v2 1/2] integrity, KEYS: add a reference to platform
 keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        Eric Biggers <ebiggers@google.com>, nayna@linux.ibm.com,
        Dave Young <dyoung@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        kexec@lists.infradead.org
Date:   Tue, 15 Jan 2019 10:54:49 -0500
In-Reply-To: <CACPcB9fQUNiD8UEVDa+bU67PZSOkckwhwD00Qvu4m3G0JmqqHQ@mail.gmail.com>
References: <20190115094542.17129-1-kasong@redhat.com>
         <20190115094542.17129-2-kasong@redhat.com>
         <1547566455.4156.283.camel@linux.ibm.com>
         <CACPcB9fQUNiD8UEVDa+bU67PZSOkckwhwD00Qvu4m3G0JmqqHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19011515-0020-0000-0000-00000306D90A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011515-0021-0000-0000-00002157F138
Message-Id: <1547567689.4156.291.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901150132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-15 at 23:47 +0800, Kairui Song wrote:
> On Tue, Jan 15, 2019 at 11:34 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Tue, 2019-01-15 at 17:45 +0800, Kairui Song wrote:
> > [snip]
> >
> > > diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> > > index f45d6edecf99..bfabc2a8111d 100644
> > > --- a/security/integrity/digsig.c
> > > +++ b/security/integrity/digsig.c
> > > @@ -89,6 +89,12 @@ static int __integrity_init_keyring(const unsigned int id, key_perm_t perm,
> > >               keyring[id] = NULL;
> > >       }
> > >
> > > +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> > > +     if (id == INTEGRITY_KEYRING_PLATFORM) {
> > > +             set_platform_trusted_keys(keyring[id]);
> > > +     }
> > > +#endif
> > > +
> > >       return err;
> > >  }
> > >
> >
> > Any reason for setting it here as opposed to in the caller
> > platform_keyring_init()?
> >
> > Mimi
> >
> 
> Yes, "keyring" is static so unless I expose it to other files, it is
> only accessible here. And I think there should be no problem to put
> the set_platform_trusted_keys here.

Right, that's a really good reason.

Mimi


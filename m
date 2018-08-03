Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6035C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FE221770
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FE221770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbeHCU03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 16:26:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729607AbeHCU03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 16:26:29 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w73ISed8013175
        for <linux-kernel@vger.kernel.org>; Fri, 3 Aug 2018 14:29:02 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kmrwmqxqw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 14:29:01 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 3 Aug 2018 19:28:59 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Aug 2018 19:28:54 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w73ISrGW44564612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Aug 2018 18:28:53 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 411815204E;
        Fri,  3 Aug 2018 21:29:03 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.98.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9AD7352050;
        Fri,  3 Aug 2018 21:29:01 +0100 (BST)
Subject: Re: [PATCH v2 1/2] security/keys/secure_key: Adds the secure key
 support based on CAAM.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        David Howells <dhowells@redhat.com>,
        Udit Agarwal <udit.agarwal@nxp.com>
Cc:     zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com,
        denkenz@gmail.com, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, sahil.malhotra@nxp.com,
        ruchika.gupta@nxp.com, horia.geanta@nxp.com, aymen.sghaier@nxp.com
Date:   Fri, 03 Aug 2018 14:28:41 -0400
In-Reply-To: <1533311338.4140.3.camel@HansenPartnership.com>
References: <20180723111432.26830-1-udit.agarwal@nxp.com>
         <8060.1533226481@warthog.procyon.org.uk>
         <1533297482.4337.373.camel@linux.ibm.com>
         <1533306238.4140.1.camel@HansenPartnership.com>
         <1533307535.4337.415.camel@linux.ibm.com>
         <1533311338.4140.3.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18080318-4275-0000-0000-000002A35CAE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080318-4276-0000-0000-000037AB7BCE
Message-Id: <1533320921.4337.479.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808030200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-03 at 08:48 -0700, James Bottomley wrote:
> On Fri, 2018-08-03 at 10:45 -0400, Mimi Zohar wrote:
> > On Fri, 2018-08-03 at 07:23 -0700, James Bottomley wrote:
> > > On Fri, 2018-08-03 at 07:58 -0400, Mimi Zohar wrote:
> > > > On Thu, 2018-08-02 at 17:14 +0100, David Howells wrote:
> > > > > Udit Agarwal <udit.agarwal@nxp.com> wrote:
> > > > > 
> > > > > > +==========
> > > > > > +Secure Key
> > > > > > +==========
> > > > > > +
> > > > > > +Secure key is the new type added to kernel key ring service.
> > > > > > +Secure key is a symmetric type key of minimum length 32
> > > > > > bytes
> > > > > > +and with maximum possible length to be 128 bytes. It is
> > > > > > produced
> > > > > > +in kernel using the CAAM crypto engine. Userspace can only
> > > > > > see
> > > > > > +the blob for the corresponding key. All the blobs are
> > > > > > displayed
> > > > > > +or loaded in hex ascii.
> > > > > 
> > > > > To echo Mimi, this sounds suspiciously like it should have a
> > > > > generic interface, not one that's specifically tied to one
> > > > > piece of
> > > > > hardware - particularly if it's named with generic "secure".
> > > > > 
> > > > > Can you convert this into a "symmetric" type and make the
> > > > > backend
> > > > > pluggable?
> > > > 
> > > > TPM 1.2 didn't support symmetric keys.  For this reason, the TPM
> > > > "unseals" the random number, used as a symmetric key, and returns
> > > > the
> > > > "unsealed" data to the kernel.
> > > > 
> > > > Does anyone know if CAAM or TPM 2.0 have support for symmetric
> > > > keys?
> > > 
> > > It depends what you mean by "support".  The answer is technically
> > > yes,
> > > it's the TPM2_EncryptDecrypt primitive.  However, the practical
> > > answer
> > > is that symmetric keys are mostly used for bulk operations and the
> > > TPM
> > > and its bus are way too slow to support that, so the only real,
> > > practical use case is to have the TPM govern the release conditions
> > > for
> > > symmetric keys which are later used by a fast bulk
> > > encryptor/decryptor
> > > based in software.
> > > 
> > > >  If they have symmetric key support, there would be no need for
> > > > the
> > > > symmetric key ever to leave the device in the clear.  The device
> > > > would unseal/decrypt data, such as an encrypted key.
> > > > 
> > > > The "symmetric" key type would be a generic interface for
> > > > different
> > > > devices.
> > > 
> > > It's possible, but it would only work for a non-bulk use case; do
> > > we
> > > have one of those?
> > 
> > "trusted" keys are currently being used to decrypt other keys (eg.
> > encrypted, ecryptfs, ...).
> 
> Yes, but that's just double encryption: it serves no real security
> purpose because at the end of the chain, the symmetric key is released
> into kernel memory to use in software crypto.  Unless you're using a
> high speed (and high cost) crypto accelerator with HSA, this will
> always be the case for bulk crypto.
> 
> The other slight problem with this chain of crypto is that I can impose
> conditions on the key release from the TPM (well TPM2, since TPM1.2 has
> a very weak policy engine) but if we use intermediate steps, those
> conditions might not be preserved, so I think the ideal would be a
> trusted key being released directly to LUKS or ecryptfs because the TPM
> can then verify the policy at actual unseal time.  I get that for the
> ecryptfs case you might want one key per file for sharding and sharing,
> and that's more like a bulk case because the TPM isn't going to keep up
> with the number of unseal operations required.

Agreed.  Yet there are a couple of reasons for having this sort of
indirection. By having the "encrypted" key encrypted/decrypted by a
"trusted" key, the "trusted" key could be updated without impacting
the "encrypted" key.  This could be used, for example, for key
migration.  Another reason would be to define a single "trusted" key
sealed to a set of PCRs, which could be used to encrypt/decrypt
multiple symmetric keys.

Nothing is preventing these subsystems from directly using a "trusted"
key.

This discussion is the result of Udit Agarwal's posting a "secure" key
patch. Before defining a new key type, whether it is called "secure"
or "symmetric", we need to understand how the this new key type is
going to be used.  Will it have a similar ability to impose conditions
on the key release as the TPM?  Will it have symmetric key support, so
that the symmetric key never needs to be released from the HW?

Mimi


Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5FEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F8F2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F8F2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbeKLF7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:59:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59956 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730939AbeKLF7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:59:21 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABK8aqX039483
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:09:52 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npd762pns-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:09:52 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 11 Nov 2018 20:09:50 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 20:09:48 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABK9lHO58458302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 20:09:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0FF342042;
        Sun, 11 Nov 2018 20:09:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE5F94203F;
        Sun, 11 Nov 2018 20:09:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.88.36])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 20:09:46 +0000 (GMT)
Subject: Re: [PATCH 02/11] libnvdimm/security: change clear text nvdimm keys
 to encrypted keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        keyrings@vger.kernel.org
Date:   Sun, 11 Nov 2018 15:09:35 -0500
In-Reply-To: <CAPcyv4jMPDap8L6jTo9NGnrJGCjUY_BvSBuPge8NL4QS2Ku0CQ@mail.gmail.com>
References: <154180093865.70506.6858789591063128903.stgit@djiang5-desk3.ch.intel.com>
         <154180163666.70506.8805433934495072699.stgit@djiang5-desk3.ch.intel.com>
         <1541957268.3734.53.camel@linux.ibm.com>
         <CAPcyv4jMPDap8L6jTo9NGnrJGCjUY_BvSBuPge8NL4QS2Ku0CQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18111120-0028-0000-0000-000003184284
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111120-0029-0000-0000-000023D49FF9
Message-Id: <1541966975.3734.78.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Traditionally there is a single master key for the system, which would
> > be sealed to a set of boot time PCR values.  After decrypting all of
> > the encrypted keys, the master key would be removed from the keyring
> > and a PCR extended.  Extending a PCR would prevent the master key from
> > being unsealed again and used to decrypt encrypted keys, without
> > rebooting the system.  Normally this would be done before pivoting
> > root.
> >
> > If you're not referring to the system master key and are intentionally
> > limiting usage to TPM 2.0, more details on the master key security
> > requirements should be included.
> 
> Oh, interesting point. I think we had been assuming a local +
> unsealed-at-runtime nvdimm master key rather than a system-wide master
> key. Yes, we need to rethink this in terms of supporting a sealed
> system-key. This would seem to limit security actions, outside of
> unlock, to always requiring a reboot. I.e. the nominal case is that we
> boot up and unlock the DIMMs, but any subsequent security operation
> like erase, or change-passphrase would require rebooting into an
> environment where the system-master key is unsealed. I do think
> re-provisioning keys and erasing DIMM contents are sufficiently
> exceptional events that a reboot requirement is tolerable.

> Is there already existing tooling around this to be able to schedule
> master-key related actions to be deferred to an initrd environment?

There's the original dracut support for loading a masterkey, which is
used by the EVM and ecryptfs dracut modules.  After the last usage,
the masterkey needs to be removed from the keyring.

Different people over the years have wanted to add support for
calculating the boot time expected PCRs values in order to reseal keys
(trusted key update), but I haven't looked to see if there are any
open source tools available.

Mimi


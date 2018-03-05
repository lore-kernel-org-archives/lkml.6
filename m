Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-819802-1520233405-3-7487455150799661868
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520233405; b=VMGa5BQajKQWB/r+kTdbima+fBZmMJ1wMWRzQSEwtZOYxV2
    sBP58evxhNOtDZyZelJhtqNV0MXf4hN8uqgXz6O9HM4IIvm6SRpsjyeKH9DgwZgu
    J0RWEN2GQZXAMMB1+CieY17C/64vcnZKWYF5m4lOx0oZ3OLjH8vY0zwKq7+UXXsJ
    5kwZh88/Yd53l4qTb94WCC+IX2p+LSgmbHsJFuFsQE4SsMJYlzVZ8TzJCuO7OQAJ
    Mr5mhaOFxFa6C9cuXKbMDsPkiK5AXHBcI8HWXmWBn2W+dM8FO4FaGyJQcLtdLl+l
    qzmwLFusLlGQvQGWN1zGQYh400wGQm2gYYY98bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:subject:to:cc:references
    :in-reply-to:mime-version:content-type:content-transfer-encoding
    :message-id:sender:list-id; s=arctest; t=1520233405; bh=wZfjGvia
    q0uCBr6DY9zkq3jz7OwdWltgkCfcQjCOSRM=; b=BpBMlry81TiNSmQaOb7Dy+BF
    xu2enWYskY9gQmJWka62dIemK+LbpeHoQ3SARdYp8Gxlt49zYJvmoShlfy59F4c0
    1rYAKmVgFw43+Xjn1XTEdrJJB55hwgHlwSmZiSgv2ZlIeSDcLzqFvddIYnwgdR9C
    vxdLWoO8mO8DwCAmIPBAkmwgxt17uF01+GQC7O37I6sphQrRZ61jfQLjygQOeTM+
    9jKVljZlxe2DXOPwgKsv0unj3y7HLm4sSi2Ap4cbtLP9wg5+MYWw/ZoWuFIP9+Pm
    +Eqb4WZrM0dSxWRcm8NLGG+G0UupQEcw7DQFQtT/1oaLw3SnjhJ/44JdSWq4tg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933004AbeCEHDJ convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Mon, 5 Mar 2018 02:03:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932997AbeCEHDG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 02:03:06 -0500
Date: Mon, 05 Mar 2018 12:32:57 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH AUTOSEL for 4.9 005/219] kretprobes: Ensure probe location
 is at function entry
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
        <20180303222716.26640-5-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-5-alexander.levin@microsoft.com>
User-Agent: astroid/0.11.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18030507-0016-0000-0000-0000052CC3C8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030507-0017-0000-0000-00002869D3A9
Message-Id: <1520232322.k5aakv6abc.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1031 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803050083
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Sasha,

Sasha Levin wrote:
> From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> 
> [ Upstream commit 90ec5e89e393c76e19afc845d8f88a5dc8315919 ]
> 

Sorry if this is obvious, but why was this patch picked up for -stable?  
I don't see the upstream commit tagging -stable, so curious why this was 
done.

I don't think this patch should be pushed to -stable since this is not 
really a bug fix. There are also other dependencies for this change (see 
commit a64e3f35a45f4a, for instance), including how userspace (perf) 
builds out the retprobe argument. As such, please drop this from -stable 
(for 3.18. 4.4 and 4.9).

Thanks,
Naveen

Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE88C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34631246F0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34631246F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932238AbeGCMgE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:36:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932079AbeGCMgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:36:02 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63CTQhr051484
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 08:36:02 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k08vvh89n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:36:01 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 3 Jul 2018 13:35:59 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 13:35:55 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63CZsmU41091302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 12:35:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04CC24C04A;
        Tue,  3 Jul 2018 15:36:20 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D56D4C05C;
        Tue,  3 Jul 2018 15:36:18 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.97.127])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 15:36:18 +0100 (BST)
Subject: Re: [PATCH v5 1/8] security: define new LSM hook named
 security_kernel_load_data
From:   Mimi Zohar <zohar@linux.vnet.ibm.com>
To:     J Freyensee <why2jjj.linux@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Date:   Tue, 03 Jul 2018 08:35:41 -0400
In-Reply-To: <64f467a5-e907-ee3e-495b-b2c731715037@gmail.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1530542283-26145-2-git-send-email-zohar@linux.vnet.ibm.com>
         <64f467a5-e907-ee3e-495b-b2c731715037@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18070312-4275-0000-0000-00000294B120
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070312-4276-0000-0000-0000379C2F9D
Message-Id: <1530621341.3452.5.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 11:45 -0700, J Freyensee wrote:
> 
> On 7/2/18 7:37 AM, Mimi Zohar wrote:
> > Differentiate between the kernel reading a file from the kernel loading
> > data provided by userspace.  This patch defines a new LSM hook named
> > security_kernel_load_data.
> 
> If this patch series is re-done, can we tweak the description here 
> please?  From what I understood of the code in this patch, I'd tweak it as:
> 
> "Differentiate between the kernel reading a file specified by userspace 
> and the kernel loading a block of data provided by userspace.  This 
> patch defines a new LSM hook named security_kernel_load_data()."
> 
>  From the description, I got a tad confused if the the kernel
> reading a file was also provided by userspace (I know it may be 2nd-
> nature to people on this list, I'm still learning this kernel
> module).

Could we replace "a block of data provided by userspace" with just
"data provided by userspace"?

Mimi


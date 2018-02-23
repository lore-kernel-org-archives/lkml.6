Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226uFEbt61kqxxHJuyB4wBVjMy80KCty2+ngvpy2YY5fDBilrSrPOrAsCTqomUcfG25B5A2x
ARC-Seal: i=1; a=rsa-sha256; t=1519414149; cv=none;
        d=google.com; s=arc-20160816;
        b=jyy3ucV68wb4fuP1mG7DIIchpCQMQT4Eu9C3emHIIU0VQhvM/mw8VBf9O3YjuoZxPU
         j8tu/LL3O4xCYCOGVdkZz/0cMc2l8Prki/zut4BDuUS0o4g+wvvWTX1Nd62nZ9nsCj1X
         hU1tjKIaiL6Q6zVO3XWr+hGFBzNMXzqcvBHiP1SCLYMWgFGE/R6r5qjc+NrGwvOVbmSD
         ElwCJ3ASgvcWn+sP2eYkNcfwUfN0xcK0Nr7UdEspoayNlczfRFnLPEqsCT2x4Fp47J43
         TBOhYhE5TYrPfBID2dFxja58ebCvtJvP9KPBZnTkUPDuU8LQySa+jn3c1eRrIOMbeJIN
         HFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:user-agent:in-reply-to
         :content-disposition:mime-version:references:reply-to:subject:cc:to
         :from:date:arc-authentication-results;
        bh=GAHFz64qkQlXi4RR3kxRcyW/pSawrJxAdEu1oVUy3jc=;
        b=VyOByRpljpw23/Ol/cnww0h1HUZJYJhJEkANeCzu+0GvCNS9RKvWyIe+jsfKtGAWG5
         DZ+Zuwq+TKYOIlfuFaYUhCJ9M9cG3h3Hw+udsxqVMhn9P46W7yJuHYaFI18Iy+omPXfS
         cu0kfKHGfTTslju5jL6Wz6OxN/YVxiEdfFwcAUFWq/abu0o5KA8YUahe+yMgsd4DkfsN
         tGCymsaQJqKJVkbjyo31HEZaB/dntu1n4bQ5Cjk0Yg42mBPbnGaKZqqkwJG0bus8tSa6
         SmKYwge2Ob/SoiuW1FqWMgwz9V7tppJp2weE2gcR+drzbCzK/o9UQZH00+I5bAeaTZj+
         lFnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754680AbeBWT27 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 23 Feb 2018 14:28:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39748 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935056AbeBWSv7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Feb 2018 13:51:59 -0500
Date: Fri, 23 Feb 2018 10:51:47 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/2] selftests/powerpc: Add core file test for Protection
 Key registers
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180223183344.21038-1-bauerman@linux.vnet.ibm.com>
 <20180223183344.21038-2-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223183344.21038-2-bauerman@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18022318-0008-0000-0000-000004D3C561
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022318-0009-0000-0000-00001E66D78E
Message-Id: <20180223185147.GJ5559@ram.oc3035372033.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802230229
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593221211865790502?=
X-GMAIL-MSGID: =?utf-8?q?1593221211865790502?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 03:33:44PM -0300, Thiago Jung Bauermann wrote:
> This test verifies that the AMR, IAMR and UAMOR are being written to a
> process' core file.
> 

Acked-by: Ram Pai <linuxram@us.ibm.com>
Tested-by: Ram Pai <linuxram@us.ibm.com>

> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>  tools/testing/selftests/powerpc/ptrace/Makefile    |   5 +-
>  tools/testing/selftests/powerpc/ptrace/core-pkey.c | 460 +++++++++++++++++++++
>  2 files changed, 464 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/core-pkey.c
> 
.snip...

RP


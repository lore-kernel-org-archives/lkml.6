Return-Path: <kernel-hardening-return-12500-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELukXysc5JVJxogNqlrLDPW4YcE3g+r7ucTCGGKoYsoMDwx2yTu8zl5oMNf09aXxFQNuZrO2
ARC-Seal: i=1; a=rsa-sha256; t=1520931345; cv=none;
        d=google.com; s=arc-20160816;
        b=BBp9xS0aO1Iof5YVYAShdnGd82XTtPvIteeVYntSxW26xuyCvOEyA3mXbkE9DJ9C4W
         ENeXk53Zlx1Dd1sgfSSlA4oox2heLJzJLBx3ptphOu7iN9Npr/k6qj9AyKqo+YtMn9Tl
         PWg8KjFFfI0lHPwTDXpKldeWb9lxJjthhJtFL8gYV9xTbqzl0uSnQw2O/idyPUSer8EM
         FjhpLPLX2meyj/cOB62B6Rsqri/BIx2okZ3xmGAvSiEnn13me7VQM/oLAkP30W2WtVQ5
         1ChTe+cxT3oSgYxqsxRS3Ir35izNHa8H7q7tkXd97l18l8JEoQ2ADQX6ZWRnS5VSa/L7
         Z9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :organization:from:subject:cc:to:dkim-signature:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=yo+W45QeHub/otjT1kUJ5UiyUz0Pb7gQ9TlDy9Jtkko=;
        b=v6hi8rGBwBcACTLzcOEe0On+bm74FSsP/zEpzcxdIBdDA3EcxK4zIeXRF3OUtLNm0C
         nWC7X335YeS7e7d1zLxBTMyWfrlFeuqVUg2T6O1jTu7huwhzmyUWdbvxEkgzjDtuFoLU
         pya15iW6mwnP1iDmLBOQv727GwCqtDzEU0z8XFIiShqDkKSfxuC0g3uVrPUyzqe3yJv5
         rfSLGbBnmtcdziRw852tVvE+tjWAUpCzJdyGKMb9gAuJTUjM79kQVLGIr7+j8UuiU3Qa
         /JucYZxpJVYXhha6BRA2HBzMDogDSVN2mxLBKcFT9GXN35+P65Q/YiQTgFHhzqocn+Sa
         IwMA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=aygPhZtt;
       spf=pass (google.com: domain of kernel-hardening-return-12500-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12500-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=aygPhZtt;
       spf=pass (google.com: domain of kernel-hardening-return-12500-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12500-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
To: Stephen Kitt <steve@sk2.org>
Cc: hare@suse.com, axboe@kernel.dk, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] device_handler: remove VLAs
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180309232933.14e39858@heffalump.sk2.org>
	<20180309223211.20473-1-steve@sk2.org>
Date: Mon, 12 Mar 2018 22:37:47 -0400
In-Reply-To: <20180309223211.20473-1-steve@sk2.org> (Stephen Kitt's message of
	"Fri, 9 Mar 2018 23:32:11 +0100")
Message-ID: <yq1tvtkem4k.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8830 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=491
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803130032
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594501121445271854?=
X-GMAIL-MSGID: =?utf-8?q?1594812106052817507?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Stephen,

> In preparation to enabling -Wvla, remove VLAs and replace them with
> fixed-length arrays instead.
>
> scsi_dh_{alua,emc,rdac} use variable-length array declarations to
> store command blocks, with the appropriate size as determined by
> COMMAND_SIZE. This patch replaces these with fixed-sized arrays using
> MAX_COMMAND_SIZE, so that the array size can be determined at compile
> time.

Applied to 4.17/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering

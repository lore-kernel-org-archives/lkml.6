Return-Path: <kernel-hardening-return-12621-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtpd8mfWafsuNEL6+BTZ/FygF3Rm1hXtAJ6IEykDWU2+mSkWfWu0ESGYufnOWgwZaGk8DPz
ARC-Seal: i=1; a=rsa-sha256; t=1521088843; cv=none;
        d=google.com; s=arc-20160816;
        b=uVa9V5DucUst+uKqKEwiNbOjhwzVOiAqHVqN5sdSFyBXqaQgoixegWF1cWc+Ms/Ypx
         38obhcSfm2lwuIxIWEhVJoQ2dCplzw/otb7a1sJA9+n8RxFz/l5ke9KkeXMXqsM31G65
         GsECP0lHHSJa/TzHosTAUSuMjrZ/VHKvIOF/jMKPizusSy9B7j+BhsDEllh1i7KHW4DP
         1BA8/PlaSjkcyuC9koOgcGhBSsWxRq5Upu33fvMqb2DDFgdqSS42vY6q+7Ma1D7jHPqi
         F23oR2ELBus/hN3X8UtXEleZXr/p3EhKakXsRzc+UrbNWaVZ30mMmu1Gh/Nuesyz86ll
         1r0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :organization:from:subject:cc:to:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=+c/cOUfLutdLkJeulA0fvT6KKWcwcVM8NGtVn4GwIM8=;
        b=bNDM9s+9kn1pZgZOBcWmqQRhjIW3C6ZrguFhjvpKoXEjXKQbYjnIjvIji9VHAVQBUv
         QNgFQwW476zxP4C9pXh32YKqX1OR2UYwaAmjim4EKudczA69E1c1hj+YGzM40Ffst5Sa
         3uDKG2SU0YDoK1ThK8dsiwHWirPMgAgtcX7l48Q43ge357jsjOba6Jh4VbZCYn2C+KFN
         hKOpDSsmu+VlwH8n7uYDMr9EC/XNvrmZA0299K5WmcUVEIfJrpzwlXLiDY1tlAl4lDg7
         q8RWG97Q7lvQc4rw5eQkKhHmkJpxwntmu0xDwBkNpNSJtfZqfHumiwVQ6CeBIFzT6NyI
         VccA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=I36EV8uM;
       spf=pass (google.com: domain of kernel-hardening-return-12621-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12621-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=I36EV8uM;
       spf=pass (google.com: domain of kernel-hardening-return-12621-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12621-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
To: Stephen Kitt <steve@sk2.org>
Cc: hare@suse.com, keescook@chromium.org, linux-scsi@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] aic7xxx/aic79xx: remove VLAs
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <CAGXu5jK=JhBFHBGpbWF46DC3-QMruiB0qqz1z+njcK2h7jVU9w@mail.gmail.com>
	<20180308205158.5130-1-steve@sk2.org>
Date: Thu, 15 Mar 2018 00:35:16 -0400
In-Reply-To: <20180308205158.5130-1-steve@sk2.org> (Stephen Kitt's message of
	"Thu, 8 Mar 2018 21:51:58 +0100")
Message-ID: <yq1d1067y7v.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=511
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803150053
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594376653072055099?=
X-GMAIL-MSGID: =?utf-8?q?1594977254939940988?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Stephen,

> In preparation to enabling -Wvla, remove VLAs and replace them with
> fixed-length arrays instead.
>
> The arrays fixed here, using the number of constant sections, aren't
> really VLAs, but they appear so to the compiler. Replace the array
> sizes with a pre-processor-level constant instead using ARRAY_SIZE.

Applied to 4.17/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering

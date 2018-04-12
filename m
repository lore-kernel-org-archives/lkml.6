Return-Path: <boris.ostrovsky@oracle.com>
X-Google-Smtp-Source: AIpwx4/W088YXToSlZWfyPdz8IRGHlZT1kapPO6Z4Law1fG+1GySkLINnfamUGMnLga+Bxb5IbV1
ARC-Seal: i=1; a=rsa-sha256; t=1523499377; cv=none;
        d=google.com; s=arc-20160816;
        b=PSw6X0r+7pOQznip0TwHExTmMJgGyt0InViyFRdDaJO2vGrd+VdBwWwILlma6OnKqP
         498RWyl8QWibX/O+hfb+l6QnRXWFCp/2Tulu1d831FKPahX9kLrOGA0DUfQ1F9olEYLg
         W/l/AGFLTdAPIegapPmZ822WZaYdfGbONWEKSuo77TBbm1+SjFixki2DZo+kQbiCUjTA
         GNgrFqVifc0/Yi7k3IuOX69+zCogdb1JbYtKjBtU1j/CgJODlcvUarRQAWdN/eDhV4QB
         gXUHbcThtNayEaqmNAr2mCOaFEmkoyqcwi9aSGcT6QJkSOaN9hkpScBrxQ7QCh1EYIPt
         baww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=9ymb+8zJQVzyqsVPop1wC11LQVJkmWdXIb0disCzzFg=;
        b=mnA/4Loht/XQjl0GJfsslcQruHqkksqeUPjCHryedRxV1l0hmJfOWHkyxXX48Q5Yt9
         MAiDWANpIEyShsJrpft0CjTRAYCxZKluqNxbab5OuQugbNIU5I9sXwQGB10YzwKenHv0
         Q424K27xuOOuY51vPkOEtiM3FQKUSmmQCIySqad8d2+t70ZimBKpNp6jDMhoiOagTqi6
         4F42UDRflTnjgPinpFfpKFXid+/lx+iob17abxztqHELNEicAHHewoUpGQk+up8PH7/0
         cKeZgsyLVd3LZJpXjZGL+YxIROvvbg4dXSGQyrbWxhBkFqMfEe1szUADbGylODzzU7HA
         mlFg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=gopCVyPY;
       spf=pass (google.com: domain of boris.ostrovsky@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=boris.ostrovsky@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=gopCVyPY;
       spf=pass (google.com: domain of boris.ostrovsky@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=boris.ostrovsky@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH 1/4] xen: xen-pciback: Replace GFP_ATOMIC with GFP_KERNEL
 in pcistub_probe
To: Jia-Ju Bai <baijiaju1990@gmail.com>, jgross@suse.com,
        gregkh@linuxfoundation.org
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <1523286216-26345-1-git-send-email-baijiaju1990@gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <7096e165-3f2b-3c81-f59a-c9a96cef22ef@oracle.com>
Date: Wed, 11 Apr 2018 22:16:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523286216-26345-1-git-send-email-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8860 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804120022
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597281379484745930?=
X-GMAIL-MSGID: =?utf-8?q?1597504883048883331?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/09/2018 11:03 AM, Jia-Ju Bai wrote:
> pcistub_probe() is never called in atomic context.
> This function is only set as ".probe" in struct pci_driver.
> 
> Despite never getting called from atomic context,
> pcistub_probe() calls kmalloc() with GFP_ATOMIC,
> which does not sleep for allocation.
> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
> which can sleep and improve the possibility of sucessful allocation.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

For all 5 patches:

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

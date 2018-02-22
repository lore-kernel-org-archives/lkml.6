Return-Path: <andrew.donnellan@au1.ibm.com>
X-Google-Smtp-Source: AG47ELsjL5eRqaAtL8o4L9Vl9br0ESC9ojnbFhRSMlfBs0BB7XGCQ+IlC9CqdoCnsu1Ujz62ZUfZ
ARC-Seal: i=1; a=rsa-sha256; t=1519276919; cv=none;
        d=google.com; s=arc-20160816;
        b=A3jHgCZwMaLv+1qrQ8qS8u8ww7c8Lf/IFVljJpAZFm1T/mBKGxxLvq4irOAW4a1YkB
         /3B5Ejk0kvHuvSEoc1tREws52FbNceQeP8mZixbraaBNZyVdgpdL9BdB/vxEoexSl48v
         19B2ZSXiY5I7PHF3NXtTtllsFxczi9FySZkKDzBA7FwcW6ws0aH0ghUMspYM95bndbIZ
         T3hRN4ekd6MNKc8pt5KtN7+t6GkVnaleW46tu5Piy0E5aEbBpWFTrPIBV1xcPYLscoBg
         /jbpbd2jnFMEX1VSywdGkbraVVOBXPhwMsihT9SObOxPJ7JgWZy26SCtCFce4v+RMCwY
         hTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=M9K+yzp+75zeZoWl7aDJ4ViGngDZtYqMhriV7I9/NC8=;
        b=jhK0dow/EOPQqUORzA39jz0K9T/EujaPSItp40hpWtq40X21LvD5Y3ev9X6xMxD296
         yILSWt0oTeP5Cn+V3cfBLxuo25rM76zPTRnGX1ygS7jNohsg8pnCWHt/S8fH1AosEg7U
         ihSlvnWKJoWlR9wuSxE/fP5NS3LbTs4U9OaV+5VkNwmSZciaUv7ZgGJj7LPNY4Lfb6sS
         FYaHgqpVXOvPuzfEEJOVbalr3ydrnZ9TkqF52YYpyXVqLowIfhZWlbksurT3c+cbcpYA
         moMwITANrk3aWp+JVcB+iUWFcXQa4NtrrV4rlW7h63/xYBd682/OCKswVgVfiz9uzIRr
         GrVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v3 1/2] ocxl: Add get_metadata IOCTL to share OCXL
 information to userspace
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: frederic.barrat@fr.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        "Alastair D'Silva" <alastair@d-silva.org>
References: <20180222030334.14060-1-alastair@au1.ibm.com>
 <20180222041739.27899-1-alastair@au1.ibm.com>
 <20180222041739.27899-2-alastair@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 22 Feb 2018 16:21:45 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222041739.27899-2-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18022205-0012-0000-0000-000005B358B1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022205-0013-0000-0000-0000192F6F9E
Message-Id: <822c937d-b4fa-e7a9-67b4-314f6f8fc810@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220068
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592985250939595866?=
X-GMAIL-MSGID: =?utf-8?q?1593077315688929975?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 22/02/18 15:17, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Some required information is not exposed to userspace currently (eg. the
> PASID), pass this information back, along with other information which
> is currently communicated via sysfs, which saves some parsing effort in
> userspace.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

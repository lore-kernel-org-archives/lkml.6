Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AIpwx48LvP51EA0ZP5uTmZbhjwP79xqCQgS+8Rgg4xarSmilJsZ8CX5zXV37kAq0aKrf53pFXqoK
ARC-Seal: i=1; a=rsa-sha256; t=1523471550; cv=none;
        d=google.com; s=arc-20160816;
        b=uNZ0/HXj70KeYn+OZYsynUM0KMHEFYlswDH7Nrp409yONxzWRMEVLO4VvQBXERKkST
         8XrR/bQXVYJu59T/A5K54nS7vry8cmZAE/FTrS/JoTa+2WsyG8g1psXlKFSq9hm5iTg4
         el3DgGu/zKykmJNYTQfb/dGgK39139JAkAoNUl3UR7mmjGVdsUgrmY2ot9uNY4iGpYqH
         vbd9MSJc21Il3h8mzJqVvGESBjWyUCNOGzk5ZAt5Q3ARFo5PxbLKzTscdb+r1RuQC5LE
         E4VFu+VKMVZjtoFXeVfznpCS1aNQdMtv+WPoVzyFe4ER8cStvrZ0ruPKzMI553i6tStz
         oSvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=NXk5XnneGq5BVYAYcs7ZJ/pmSvNCtpXtEabvpMbBA0M=;
        b=Kz9INFe4ZeXMD621x6N19k7pqaUCgN7W5Q2lxMFVdSGCt0N0lnvmKpwUFsmqkPJ6y1
         ZSOM4IxoOKzkJGjWDnOXNwbmnWB67kEU0vTuwwPOEI8KOvuv3v07fgzUw+f8nKEZEcJX
         EYIFGLlhMxcGFX0HI6R8qZTvoZESX4M13s9Ii6s4uvM2ewGrj3eQt6XwWHRBep9LrXUt
         VaCE5XF80TEU3J+O50W0vUCF7nSxa1LXk/iKsNdYRS28pTS/f74V0Je9XH9XP9OxcY5Q
         4MK9kIgJloVB9UwdxF071g2Zuto4vtwBGEATvBxfqqWhYObnuZZN53BiI8RAVEsnNcoK
         tEAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=COyWEFRg;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=COyWEFRg;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Wed, 11 Apr 2018 21:32:16 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Greg Hartman <ghartman@google.com>
Cc: Alistair Strachan <astrachan@google.com>, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, devel@driverdev.osuosl.org, kernel-team@android.com
Subject: Re: [PATCH] staging: Android: Add 'vsoc' driver for cuttlefish.
Message-ID: <20180411183216.hn7l5djgrzezomtr@mwanda>
References: <20180410190647.82986-1-astrachan@google.com>
 <20180411080536.sw6tesgi3vqgxxpn@mwanda>
 <CAOvepGkHgJwZs+LtLb+10yXUkLrRxazEJk3o2he-awhMV3WMMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOvepGkHgJwZs+LtLb+10yXUkLrRxazEJk3o2he-awhMV3WMMQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8860 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=467
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804110171
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597387330232855771?=
X-GMAIL-MSGID: =?utf-8?q?1597475704451751836?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 10:49:47AM -0700, Greg Hartman wrote:
> > +     /* Ensure that the offset is within shared memory */
> > +     if (((uint64_t)arg->offset) + region_p->region_begin_offset +
> > +         sizeof(uint32_t) > region_p->region_end_offset)
> 
> I'm not certain if I understand the overflow.
> 
> arg->offset, region_begin_offset, and region_end_offset are all uint32.
> 

Ah...  You're right.  I didn't read carefully.  Sorry for the noise.

regards,
dan carpenter

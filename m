Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AIpwx4/RxStoYZqFvb9eGe8zEujEu04J2g2V1IfJnjplidWfI0uwsaIi2wLf9iInu4/H2n535ovP
ARC-Seal: i=1; a=rsa-sha256; t=1522485727; cv=none;
        d=google.com; s=arc-20160816;
        b=pFtynV64YSNCB8Z18vHqQBKi0PhKkv1RaT8LmeicOrjRRfLpAoUD876l1htcE7R0RO
         PFfcacMso3/jVQmD9NKgThH+8j0suuAYngConS8DuDR7vIGKTyN62vKrC51aiAFDEuhx
         3+H2LD1lPfKQ65OeSym1oJ7at6MK089NAy7K8YxuRa7RfBRaquEFrdY6nsmm1Hhk5Pnq
         TdsuPiUYzXvwtGQ3CdWB6rpo5NTDnuvINePT58lp8b2W/SNk3dNI6DJWsDs7zITUgyco
         iHqNnEcwA+TLJsDtPmHHkdjakSyObzw4cZfVDt9HzPzLNdC0gk6JlOK5P+q6TJ64S8u8
         78/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=DJ4bV79OHpvMUIICQnwEjm4WdOgzSLvG1QbDIrmeHGo=;
        b=X20bF0BNmSbrxMkyNrIXXqhMylc9JzQIz54cD/IZ0x76ZcdwnprhIZ9BF35JHlL1yp
         yFT+jsCtNLAKCB/iCdSVWeLz53Y/O1/cXdL8aAh+auUeqFKXF1RWnvTKAVh64QwqS+t+
         vmw0xxTNaRNFA7WHq+jPE7q2iSj9whdhcPUVOE+LY/kq1349E88h96soqzLMyFhDbYa9
         MT2heoUZzdbJ3ypgklon2LxXE7m+CVENgxihSQRTctVIRI2wdeg1v855myMoBauHfwJX
         OEYmh3QUz8f0TPho5LMXTtMPszd3/pkEDjXmVfjA+78rlOrwYBydYQtzAPgXlPAn7KGl
         lpRw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=g/L+dtnz;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=g/L+dtnz;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Sat, 31 Mar 2018 11:41:50 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Joe Perches <joe@perches.com>
Cc: Quytelda Kahja <quytelda@tamalin.org>, gregkh@linuxfoundation.org,
        wsa@the-dreams.de, devel@driverdev.osuosl.org,
        driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/75] staging: ks7010: Use the ARRAY_SIZE() macro to
 calculate array sizes.
Message-ID: <20180331084150.e6uottdsdagtywbp@mwanda>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
 <1522478173.2210.53.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522478173.2210.53.camel@perches.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8848 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=753
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803310085
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432385681826765?=
X-GMAIL-MSGID: =?utf-8?q?1596441993849775423?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 11:36:13PM -0700, Joe Perches wrote:
> On Fri, 2018-03-30 at 23:07 -0700, Quytelda Kahja wrote:
> > This macro, provided in 'linux/kernel.h', will calculate the size
> > more succinctly than a division operation.
> 
> It's nice that you send patches, but please try to send a
> cover letter with your patch series.
> 

There are obviously times when a cover letter is required but what's the
point of that for this particular series?  What do you want the cover
letter to say here that isn't obvious to everyone just from glancing at
their inbox?

> Also, 75 patches is quite a lot for a staging patch series.
> 
> Please try to send fewer patches in your series, say a
> maximum of 20 or so and see what happens to those patches
> before sending the next set.

Do we really care about that for staging?  I can review the first 67
patches basically automatically so they take me about 5 seconds each.  I
feel like splitting it up risks introducing more conflicts so it
actually makes the process harder/worse.

regards,
dan carpenter

Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AB8JxZog8CeCr6BQuLXY8B3/IK8LVyptH84Q7Y/B8XpX3o7yKuIMW9/3Zg2doON9GL8fSCTYHoZZ
ARC-Seal: i=1; a=rsa-sha256; t=1524734888; cv=none;
        d=google.com; s=arc-20160816;
        b=UGZ3cwEkhUBPLx/EmvhYvnLnYDl4lTTE61MlFzDpNO87EVonJMdjwAeWM1LK4IPs+p
         kxbbMZrZVZeXJKPYHYN2R+em95CwpjubUAXJcf2bpS/yw2ngBT82pT3eVPyO1Orxi5/J
         Von6z2kc9qJ8QS9d21g9fbcV1aW0xbTnxYXeroC5uxIDC+0mMyufnRpkIrlYiFCJi0SI
         TSlb1mF+s51bPtP6ZiGLRMzS0fWSknBFMJuDxNXAJGt8o0W0dxmxpLnVzBOtLa4TAj8l
         CoZHnYEcA/Fs+b62kwHpDjNpLbJa/KqlIQdtaw+pHVw3VaEdgHTP4S8V2fLBORIt0k0d
         uepQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=YODlGpeJLtwQyvSydBb9qe3rwADi0nhfumALrlAdf3Q=;
        b=E8of8kk9aqaqHV7F1OIkh8XTd9RgF+lMZQtvToY2ZPmNjY+ksxd9IDyoM+Q2wCe9dY
         Gd1LzaXCy2TKDqG/OQ7hYHme6ktlAmq6O5VQ41b4Ds70O5hnkkY5eibFy9vr1gGYSn3u
         RNCkw657n230mgecin96443ye2Pxd15+lKhRtvsJ2NeaXE25mN+bccU9iv0Mj73EbI3R
         fhwU+PTKRRwPxkAdukhHU8IJGkGb5VBHieh/rjjXFyNzU37ZjHvDgnJScAWz6Vfh+2pE
         34U6LaZBBKAeHpczYjTzoSs7qWOHT1IawwxcslnPKK27Eb+IqScSo0wfiSg3FXLmAUOG
         2RHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=iJHnaJgY;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=iJHnaJgY;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Thu, 26 Apr 2018 12:27:47 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sun Peng <sun_peng@topsec.com.cn>
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        security@kernel.org, Tony Lindgren <tony@atomide.com>,
        Lars Poeschel <poeschel@lemonage.de>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/4] tty: n_gsm: add some locking around gsm_mux[]
Message-ID: <20180426092747.4syb5vf76qldr5uo@mwanda>
References: <20180420083028.7fq3hw2mjjd7nrra@mwanda>
 <20180426055235.GA15229@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426055235.GA15229@mwanda>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8874 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=428
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804260091
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598786877972804607?=
X-GMAIL-MSGID: =?utf-8?q?1598800410119688490?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Peter Z points out that this isn't sufficient...  Let me try again.

regards,
dan carpenter

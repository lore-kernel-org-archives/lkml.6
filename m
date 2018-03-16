Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3138867-1521209876-2-12531701492649881597
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521209875; b=KUROdxL1+Nw+4v0LsLOW2jpm/LTjT6jW5uTs5MaVYFgeaac
    MIa4akv3SPLfEH5QzXYhblTZ19Hql53BXezGqY70nyM/2rmPH8XzEVpxDqjMmvFm
    qw6VhVMGk9UCTvz7efQTbTXf23Knkr2z9xmOHdv2N5DuJ/uidazaegGEmJ/XOMgK
    GF8hN1FWt8SWs5VgAj+ong4N6nFiBQeAi3uZ6fsYOvePSgaIbeai/xT3Ulsdluzv
    OXVL0O2/znmAWMLGgjXF4XHxodTkuMZQKFLy1rmsLBwHve4FmR9XsEU5Uxl/t04m
    sxV8rvQ4o1Q8S6EU3M48YBpZmUKEoCA8pnqtNlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521209875; bh=m
    CBo3P28rqBLoqJPV9Bys+DWrJxwPva0kcWtNurj/x4=; b=q9k1PUvtXs3YAG/BK
    2W9LiJ12OXZcjLdIbmIFGoo48qSUBycE8jy/ahQyRkxTOvQ8VBbT/rRow62G0NUh
    KQ+4euokyM11nAgQO7i+gFRlkfI1gUntt1Ea8GEiebF+H/VJf3Ig1HzTyyoa8eVz
    S5xIHiJBijabrrnd3l+2XZ/Wcm22O0uzQ1aHi5gL5IHEx5n5gKfK7DX2Updv0mt5
    zY3pwZ7t88MF9LxXy7OWXQLwVtbWmngnjxI3uTbXBMcBcHwt28FEv9yv1niS7M/T
    UGpibRTA+D7WXY+9oCrCsHHJD8CwgGnLkiHWqkktbanRnuA85IkcAFTbQXLuoPcL
    +e16g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=KYKW9OLC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=KYKW9OLC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 16 Mar 2018 17:17:27 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH 7/7] staging:iio:ade7854: Add proper error handling
 condition
Message-ID: <20180316141727.ia3mrwnmtkge7elm@mwanda>
References: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
 <72d5aaef3445edaca08498b4d7aaff19d4ac0232.1521037060.git.rodrigosiqueiramelo@gmail.com>
 <20180315121115.iwkx2dfikgpjeeec@mwanda>
 <20180316002800.mvy75in42y5j2dpz@smtp.gmail.com>
 <20180316080257.dlglfjespmltwo3u@mwanda>
 <20180316135946.b7elcisgkfs4ibwy@smtp.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180316135946.b7elcisgkfs4ibwy@smtp.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8833
 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=618
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803160153
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Generally, it's better to fix the bug in the existing code, and then
do the cleanup later.  That way the fixes can be backported to stable
kernels more easily.

I don't know this subsystem very well.  Perhaps Jonathan doesn't care
for one reason or another (like maybe he's not going to back port the
fix).  So it might not matter how you do it.

regards,
dan carpenter


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

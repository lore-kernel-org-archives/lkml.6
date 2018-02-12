Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-607806-1518419115-2-15032499079009743662
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518419114; b=nAjK3Fo493MJIsAQGePu/SLsgrXZ61xjezgu0DK2pMls9Iw
    5A3TfGdIaC+5LwYAEm9E3X1KAkZXFGyqOPLcSpp1kDzdYXO+Um9X3oShDlPVw9KF
    fK5chZSXKNMiE6qgN0rtZ+VXha3xISWPRNNmS48vMFiF2FAoUHYU6Ab1hsVm9fHo
    MfeYJxhNjvWDLhIj97Dm1abxI7XA3Sdg4VJWQrDvixkew7Dwo01I37Q0G43Kh96z
    qEIdGDPogZHkjr4hwMcFRzGsx3XdU1WplZvZwWBnihnu0tIcHtFUiym67dZZiCaX
    L3aSbKeiJuK2wyq3KdIjGG8/d2/5Pf5gioEhfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518419114; bh=O
    4ts6EYOUoKm7HQ+r5tqRNWwzq1muZ1aWeUL/IJsq4I=; b=iJMOk17jtO87HOMru
    756A9LkySTGsnBoZFcD5GeSjPaQ6ww3kWJUL1GH79WUttCiuObiHeyMMPTCzxggQ
    slflxw0ImxF4T1ke68JvytKzgm/GCkIm/L+kK6Uo82tFxYRuuKTOv0Ns9zjJGcBR
    FDKKOwLnL1vWc0ZxtxrTjiawwBw/nNcK2NufNQBu6So6wDDZXwNkw+RzXN4UQDpQ
    fZH84iKC8OkA3eVFHR/u4P7DuCFLBumcp79CMLFLrfYUCDUUb08NlNbxMiJwYhMa
    aki2vufoQ77xNTT3EybtEzYBb6DY7T0WpeBRhYGEERKDssq6gy3IHzlKjvJUl1Vp
    p7/nQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=i3V+LLDh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=i3V+LLDh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 12 Feb 2018 10:02:19 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Dileep Sankhla <sankhla.dileep96@gmail.com>
Subject: Re: [PATCH] staging: vt6656: Fix "Possible unnecessary 'out of
 memory' message" checkpatch.pl warning
Message-ID: <20180212070218.va2zivzu6qdejk3n@mwanda>
References: <20180210161621.22246-1-sankhla.dileep96@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180210161621.22246-1-sankhla.dileep96@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8802
 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=475
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120091
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
Cc: Arushi Singhal <arushisinghal19971997@gmail.com>,
 devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Forest Bond <forest@alittletooquiet.net>,
 Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>,
 Jitendra Kumar Khasdev <jkhasdev@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 10, 2018 at 09:46:18PM +0530, Dileep Sankhla wrote:
> Signed-off-by: Dileep Sankhla <sankhla.dileep96@gmail.com>

The subject is too long and you need to have a changelog.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

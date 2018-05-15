Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AB8JxZrpcCYuSu7UeVeLd24J9AAXGPYdVjjQoB+bAmUgSS6Yujgy4QJWKxZ+hlBuwY55XDA7Bots
ARC-Seal: i=1; a=rsa-sha256; t=1526386904; cv=none;
        d=google.com; s=arc-20160816;
        b=FkxohRZX0QmWnSg+G87MHQLlgbTr/vse5iaGj36O+UnQXiexQGXrWu3vnxhL2PXeIr
         uHlMNBBAXvaGvwVIKIx65VRXMy2iFC8EU7NeDiQH1AzJslXC+xrWFiqIkE6cKFO/GAT0
         THr8dEP7HfkQWD/Ta/Zsesq/HFFI3ts+6ykW793pdUIsZTtPkQZxGX8/40wM74lt52IB
         KOu53zZaLs1DIFFfOyx4L3Q41qH4dmHP4J3mqs2iUA6Z9ocvC06DTenT3FxgFOZQ7cYs
         xQ5CV2Kyvev4nc0jkjedxz3UfJUEc2LIhJIUYTeC7jEsxFK2BQh2wR60dLto29f4X+Rj
         wQWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=hYrguxMRDGcUXRIbEBVi2KW9sg26tk7WpU+hL/J/Zd0=;
        b=vYA019kkBCcLv4nDHea70SFhqIYUyeaPChC5GbxRxtUKEny7TzuM8eaOw5Vevw1qpl
         uLt0muvpUd5wleR5y+vGF2/Gtg1UlEP/lLH3kdBxnl5BzrgAuT1sk9ZfuHdbUE6zF4kV
         atjwVK3csHTE6rHuFUO/MnObNcSDaUQfZZFxMzanDRC/90QWm2J7QlF2WLRS8Vp+VfM1
         wQSZu9Wv8rDJPdoilJxRQwqpA/1nE52y+eAbh7yeaTaMeaMIyfpzN7JPZAcI1zjbZsn9
         emVhj338qHAs57tlBtnDQudKdMSgcX2bChYSW14noznrodGHSLjOQ6Z4MuKaake4BO0j
         nahw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=LntqBZLu;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=LntqBZLu;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
MIME-Version: 1.0
References: <20180514194254.14748-1-pasha.tatashin@oracle.com>
 <20180514194254.14748-2-pasha.tatashin@oracle.com> <20180515073744.GA28338@kroah.com>
In-Reply-To: <20180515073744.GA28338@kroah.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 15 May 2018 08:21:03 -0400
X-Gmail-Original-Message-ID: <CAGM2reYnZ6q-2XCJ+7=6g+8OPvujCwnhXX7BMQbOLemSTpJY+g@mail.gmail.com>
Message-ID: <CAGM2reYnZ6q-2XCJ+7=6g+8OPvujCwnhXX7BMQbOLemSTpJY+g@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] drivers core: multi-threading device shutdown
To: gregkh@linuxfoundation.org
Cc: Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, jeffrey.t.kirsher@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>, tobin@apporbit.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8893 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=907
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805150129
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600469847842803826?=
X-GMAIL-MSGID: =?utf-8?q?1600532674372211833?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

> Can you refactor this to be at least 2 patches?  One that moves code
> around to comon functions to make the second patch, that adds the new
> functionality, easier to review and understand?

Yes, I will split the patch into a two-three patches.


> And I echo the "don't use kerneldoc for static functions" review
> comment, that's not needed at all.

It was my mistake, I did not realize they were kerneldoc, I simply tried to
follow the code style of this file :) I will modify comments not to be
kerneldoc.

Thank you,
Pavel

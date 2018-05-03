Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AB8JxZqBkB+Xs2eib86iM8XnIf5OFYEi07hKHO2l7lGxuJ54a9DSJzxYRgGdK1uizNbgp2xn1aYt
ARC-Seal: i=1; a=rsa-sha256; t=1525357428; cv=none;
        d=google.com; s=arc-20160816;
        b=GwGIDorr0aD+uUDLuLSefHdqtSztoxXMarhR7NquTlhdFlD8wkBMrnS2XP00vraJ1c
         C1KwQFmg8v4nuLEUmgdXlEs1iq8O+P40Q4f+1LwtiJxZMr/yA0EGuyyiLWpH56gcG7D6
         falpg4oVJyBlURko9jYudD2hv6nKPS+3FSNy+ubc68Xubv1qEUZICeNwON3jpsy2DRSX
         inZowPVFRu1CV7HbmIvgtl1R/wr8pD1fEcNO/mCgcqf4+XomNEGx1bzIQQwuzdfETcBU
         2qnXiH1vUHwXRe84eua3xvWXaWVw0cLSRsDtZdjb4qLWaDKIfywDQr9c7TevBOycH8pB
         QrKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=P0uPyDcGLK3i4kZAIQFVSn9+RULqycjAo+0pGeGkxPo=;
        b=q/qBgY9dLJtMYiGIJQmn8XdeqWIPin9IO9LviCIH85Dd6CfOrlOWdwC07MOgdzqU1w
         KUCIPer7I4YtAfPI1zqVKbwoIbbqwlAm8ybF4//nuwB3TX0sI4pW9s8VLUHN0QWzPqMG
         SOf1CC+gXPh3TtbL0My0zktAe9vXJA3zm3IA4wdBPmxATY1fiGx+BBPn6WfZ6Wtfmy7V
         fVEFpi0aWlDL/I1QVq05ab/Sfcf0ZGNCMBBFoFE7WGaYTzxFo7kJugoFoSZ86xFJAv9E
         cUQz4VVVYV3FpwmYJkGx+szQTp94fdL1WXnvj/Yy822w7ABqZDncdzgGqlSBzIGAyNnH
         ln+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=h51s3bYv;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=h51s3bYv;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
MIME-Version: 1.0
References: <20180503035931.22439-1-pasha.tatashin@oracle.com>
 <20180503035931.22439-2-pasha.tatashin@oracle.com> <CAKgT0UdocfEm9oXZ1dkEMari8m3OA4uVTrYg45uj9fk2V41bxQ@mail.gmail.com>
 <CAGM2rea3XXJ7OqGeAdexyOUb1_7W_84t5HAb_hp7Rb=TkTM86Q@mail.gmail.com>
 <CAKgT0UfNBugQywBZuepUJ6deEYsSWmTw3b6VbQBJLn-kKXe7ng@mail.gmail.com> <50c9ac34-3971-ac1b-0b5e-1bfa004fd4cf@oracle.com>
In-Reply-To: <50c9ac34-3971-ac1b-0b5e-1bfa004fd4cf@oracle.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 03 May 2018 14:23:09 +0000
X-Gmail-Original-Message-ID: <CAGM2reZULTOcK+_VypXJjkkCNZbALuR_FS-t7ix-Wpq6AKXdjA@mail.gmail.com>
Message-ID: <CAGM2reZULTOcK+_VypXJjkkCNZbALuR_FS-t7ix-Wpq6AKXdjA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ixgbe: release lock for the duration of ixgbe_suspend_close()
To: Steven Sistare <steven.sistare@oracle.com>
Cc: alexander.duyck@gmail.com, Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, jeffrey.t.kirsher@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8881 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=704
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805030126
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599413925684033451?=
X-GMAIL-MSGID: =?utf-8?q?1599453190193624682?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Hi Pavel, you might want to pull lock optimization out of this patch
series.
> The parallelization by itself is valuable, and optimizations for
individual
> devices including locks can come later.

Hi Steve,

Yes, I will pull this patch out of the series. Thank you for the suggestion.

Pavel

Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZoHoLyHSWet02pgLJOyB7OBILQksDJFYbn68IY7pzdjXC3AWPQqXxVazfwr3lWjvgS6pH9O
ARC-Seal: i=1; a=rsa-sha256; t=1526388247; cv=none;
        d=google.com; s=arc-20160816;
        b=j7euTZEwdIM/LOZNy6OSmLlvIdQFx3hsmV9D5fzT1jkyrdlqAIYEbo2ghYIVoWNX8E
         BKnv2yebrzB3+Y8KzsXsyyWAKiqprKQ2djaceFhVIVhnjBKKEAk0tFraLiBVApIe/1DE
         Ldn060n70c3l8iKYpXk05j4bB/YUj13cborqppq9QQSyLVBVGypAnwMN7rH7IZSco0q6
         e3e7yYipCnQLIBX+SLj21b+WjZbYBRC4RvuBwfuPlHytcUDZvf0nsrhWC4qXvdDINM3A
         zZo4+SxeUPCzJk7tMNHruuPvvkRBiIQV4zZWlsoMuewOo17tfd9BjszF1Np8x+zkEwnh
         cBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:arc-authentication-results;
        bh=Q+BJR1i7qyAeRBGv1YZRu8d9xqbb1KQofr0r4zZUSGI=;
        b=z8G+tjtMmmozUK8XavHMFzq2X+qoJ07gzNTIUXIeD3zAiolZIXMB68CLjbc4hdYIYD
         YngaJogpFd1n/37HXeJ4qxAEitlhybwL5dZeYheCOdKDr2seREpKI976A+mW7Cw/UyAK
         XWHG0dYP0sCq0f7PHl1Fe2aPxf1SnymT/rDkQ7lVLwhmYtORGGkjFQ4bodupqNQmJ0AN
         QHmD+e7ZuRyQ5koIxYk161n759BLpnibMoCSXYTaKy1hg6hIIqQQlCHoLd1xssQlW5mj
         nEEgs2/KO2iORAuFlw7YMlmqWD/KfzPx4vROomcJSyJ5uTjJkZwt4s5cclIId6t6z+du
         nlYw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 3/6] firmware: differentiate between signed
 regulatory.db and other firmware
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@kernel.org>, mcgrof@kernel.org
Cc: Harald Hoyer <harald@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Eric W. Biederman"
 <ebiederm@xmission.com>,
        Casey Schaufler <casey@schaufler-ca.com>, ast@kernel.org,
        David Miller <davem@davemloft.net>, jeyu@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        One Thousand Gnomes
 <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter
 Jones <pjones@redhat.com>, takahiro.akashi@linaro.org,
        David Howells
 <dhowells@redhat.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Seth Forshee
 <seth.forshee@canonical.com>, johannes.berg@intel.com,
        linux-integrity@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Ard
 Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-security-module
 <linux-security-module@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org"
 <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH
 <gregkh@linuxfoundation.org>, andresx7@gmail.com,
        Linus Torvalds
 <torvalds@linux-foundation.org>, luto@kernel.org,
        Justin Forbes
 <jforbes@redhat.com>, Laura Abbott <labbott@redhat.com>
Date: Tue, 15 May 2018 08:43:39 -0400
In-Reply-To: <CA+5PVA7QU0k91zvoBTAFzG+unkh-=-s9Lhk3hn3eTJhHo4ovCQ@mail.gmail.com>
References: <20180509212212.GX27853@wotan.suse.de>
	 <1525903617.3551.281.camel@linux.vnet.ibm.com>
	 <20180509234814.GY27853@wotan.suse.de>
	 <1525917658.3551.322.camel@linux.vnet.ibm.com>
	 <20180510232639.GF27853@wotan.suse.de>
	 <1526014826.3414.46.camel@linux.vnet.ibm.com>
	 <20180511215250.GJ27853@wotan.suse.de>
	 <1526302692.3898.145.camel@linux.vnet.ibm.com>
	 <20180514192853.GM27853@wotan.suse.de>
	 <1526349751.3937.78.camel@linux.vnet.ibm.com>
	 <20180515032656.GR27853@wotan.suse.de>
	 <CA+5PVA7QU0k91zvoBTAFzG+unkh-=-s9Lhk3hn3eTJhHo4ovCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18051512-0008-0000-0000-000004F6AD70
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051512-0009-0000-0000-00001E8B1354
Message-Id: <1526388219.3937.137.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-15_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805150131
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599489927866627191?=
X-GMAIL-MSGID: =?utf-8?q?1600534083287638478?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-05-15 at 08:32 -0400, Josh Boyer wrote:

> One aspect that was always a concern to some is whether the firmware files
> were modified directly to have the signature attached to them.  That may
> run afoul of the "no modification" license that most blobs are shipped
> under.  Does IMA have the signatures for the files stored in xattrs or in
> some other detached manner?

They're stored as xattrs.  RPM has support for including file
signatures in the RPM header.

Mimi

Return-Path: <tedheadster@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517633571; cv=none;
        d=google.com; s=arc-20160816;
        b=HzVbHiq7i7bztmfEDhNi1VW0RvRxVxQOw2wFff5tC8BbQHO1UZCGO4qhrv3AyQnRt0
         7X+m3zWXfhqrw1D7PH7+wxGjO+86ghczsUwTGnBA0SZXSP7owk2KTKR1a77DY+EpSBXH
         2TylHQVMz641mlGMc1k2jztPE/hfhqaDqib7++UwqlkLmrui1JEyXsMoE/V8CdD8vYxb
         23FdotlYHviWujcwEmskNVC1vHEEQbQgqiwa+MkvAxCu5WqTWsM3RwMxGZmGpbheS/+Q
         iGM7yL7nSIHrI1If6JGeuKeZzQX6gpvL0wIox+Rr7JJoGdoPSg6I2Cnbbe0I8/xehG/z
         eY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :dkim-signature:arc-authentication-results;
        bh=OuFzorLWLYmQdiU4hzCvfganE/CfwFShhx+Fnk0HeCM=;
        b=T8b17/r0QVl8/lJ1inJYiGBmSDvZcJaWEiiKgcFsBr51i/1qPYI2jVwzjp4tun3yst
         8NImTGCaSeQ9rXt4HKf98vNx0qitibyQae/hIIVgdjn/2CZ/NnKkEGpnAkr+vknaMwqb
         PQiAWVv1ohkFVnnDJgr176rm/pC8yVDOvvxZFsheAMYEbPn0LIkpCOMYWcCqld3bzZ7J
         BZ7Y9Tsk4oWr5ABzElM2EyFJty22ZnV6xUWko14oiDRURDlOFijK/WNPAH6tQWZ1PKOB
         kXjKse0G4TRlujTozBAMoxM2u5E1wQjdL8MDs3BtqGkLnFqVRn9Y7ZTaTp0SIXilKNzA
         pWvw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PktR55rB;
       spf=pass (google.com: domain of tedheadster@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=tedheadster@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PktR55rB;
       spf=pass (google.com: domain of tedheadster@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=tedheadster@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227qautUeTXfyZe6D4ak/G8dwS85Pe+YQW8gruCN9boJvwiNH0hkedzpQsqaREHBrrG2JIgB3MSEtqz4DffcwCA=
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
From: tedheadster <tedheadster@gmail.com>
Date: Fri, 2 Feb 2018 23:52:30 -0500
Message-ID: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
Subject: [BUG] x86 : i486 reporting to be vulnerable to Meltdown/Spectre_V1/Spectre_V2
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, hughd@google.com,
	dave.hansen@linux.intel.com, jikos@kernel.org, bp@alien8.de,
	linux@roeck-us.net, Kees Cook <keescook@chromium.org>, jamie@jamieiles.com,
	dwmw2@infradead.org, eduval@amazon.com, labbott@redhat.com, riel@surriel.com,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591354140743903681?=
X-GMAIL-MSGID: =?utf-8?q?1591354140743903681?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I just tested the 4.15 kernel and it is reporting that my old i486
(non-cpuid capable) cpu is vulnerable to all three issues: Meltdown,
Spectre V1, and Spectre V2.

I find this to be _unlikely_.

/sys/devices/system/cpu/vulnerabilities/* reports the following:

meltdown: "Vulnerable"
spectre_v1: "Vulnerable"
spectre_v2: "Vulnerable: Minimal generic ASM retpoline"

The output of dmesg includes:

"Spectre V2 mitigation: Vulnerable: Minimal generic ASM retpoline"
"Spectre V2 mitigation: Filling RSB on context switch"

Also, /proc/cpuinfo reports the following:

cpuid level: -1
flags: fpu retpoline rsb_ctxsw
bugs: cpu_meltdown spectre_v1 spectre_v2

I have the hardware to test on. Send me your patches.

- Matthew Whitehead

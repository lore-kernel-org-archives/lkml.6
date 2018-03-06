Return-Path: <casey@schaufler-ca.com>
X-Google-Smtp-Source: AG47ELukgfekYZPRmO5pOzuwwT8nYaXSGK/Qq8XCtK/tFWeIPzt3b3J6BiUSwWElctIElIhHWMU9
ARC-Seal: i=1; a=rsa-sha256; t=1520364521; cv=none;
        d=google.com; s=arc-20160816;
        b=AqG1eb7a4QxEx3kt/BP0x4twZlvklEQd9Mnq5JgJwu8WwVTyd3NPg5xtsf2KrYejLC
         yal0rTi1gF7SViV8PDnPvJh2JTVsYoAj80dke3ZgXOhFzOsK43WBVmhFVt/e1gLQnrmq
         ZKNEOSfyge0OMgrlxJpiWG9aqJspPc8sgwqGjbwcJ/phlNUPE2v3nGh11p1MJGUfNNmS
         E/Jlq3gcg0dTJGKol/CuV2vjmfwoiPbTOvglqIR1fx9X/rh9asiXJpkWIYWgiAWX8gCP
         CAUPp1JrUGRvQm/OX6Ye5qUohTdvfz9d6xaN8T21AL3XpM8PvMdIzJC3tYjHdJp5kiA1
         GFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=+O2oZT7velq8FjCrRDD41a8rqQGTNDIJEfat6YUfyfs=;
        b=nIUrtttNdjuSObp9RY8fEzrsxdCp2AqPst/ESTLcMQ0rBbTVgpXBQoLDYNb0n8leGc
         j5p0/KcM30B9rN8yphGpPjm5z32m2/2Nm6QlBI+J2qFEtNwXU+6ovocHmEMThAjdale5
         ezlXgB9C1VFlBUzY/sVCrW4+++P/7MjjvE8JOYdPCPL0n0jORtjLOxa4KbQ7BOzvmiwY
         nDv3JKDWmT0rB88WVxu9M2D5m6LKp91ku666kjAXFjC784W19pcoJPbs5HaBDthuEJss
         rfO/WY8+sOaE92Cpy1/7JyQFs64yBsJBCU7GeS3Oowt4kDgEsX/ehfzWYMC3oA7/CAg/
         FdSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@yahoo.com header.s=s2048 header.b=b7QL25Ly;
       spf=neutral (google.com: 66.163.191.154 is neither permitted nor denied by best guess record for domain of casey@schaufler-ca.com) smtp.mailfrom=casey@schaufler-ca.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@yahoo.com header.s=s2048 header.b=b7QL25Ly;
       spf=neutral (google.com: 66.163.191.154 is neither permitted nor denied by best guess record for domain of casey@schaufler-ca.com) smtp.mailfrom=casey@schaufler-ca.com
X-YMail-OSG: F.2MiJcVM1lvVT89mTF.izCnSf76gBosgieLdzpfXDDhnZib2q1bluA6M9J6ey9
 UDxV7jXxH1foLut6JAI3.KgS73HJVpEWe9XuutnqBZTuBxiyIsVlCXCI_UdFIsmD.G0hrHoEkfVI
 yBXjswVyI3scg_rjygg3Y0e7gZSKbrmMJCPkVGWm7oTJ0PJJruaesOrNSJyu5BAu5DxoCHxb8.TP
 piIwllAswcuYMjqHizQH_PaRPjGC1S89FCdmLpz4PKG4t4CHM1qfsvXpOH8IeYwMTA5aVOwUfzAA
 tjUsPV_iVtzYWrnBGdoEdraS_xWD_jvmt6QXvRjQgrOFOkAL08Wg74TMzn3dCTe_732TWiZE_xH9
 qtWCjVUv_YiNSBvaFnETWvobglwHAgJStji_9IjcsB5118ePW1x_FSd_MlYT6nSQGWCxh__htoJA
 JrWXGZmifFnOZKKbeITyNfTnLCbuTl0Iv99SNxJDNbA8M1H1_6NKFo3CWPZ9s8im9ekdFiUcgfyZ
 7hDN0e0snfGlR9hrv7Y12SJmUWx_SmqBrWDYvu8SIB53yiu6cYOi_l9AkMS1yU3MF9oMaTBM97Bo
 D.Alq0EDqf_AnPm.uuXsT2.ZbHwmb58HizTYxpb8D3VgmJubWaanxJ5TzqWFz7IU-
Subject: Re: [PATCH] usb,signal,security: only pass the cred, not the secid,
 to kill_pid_info_as_cred and security_task_kill
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 John Johansen <john.johansen@canonical.com>,
 James Morris <james.l.morris@oracle.com>, gregkh@linuxfoundation.org,
 serge@hallyn.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
References: <20170908164001.21138-1-sds@tycho.nsa.gov>
 <CAHC9VhSga+mg8VTtVoafdbpQ2K62PEBGrWidB8SUwWtRO+hahA@mail.gmail.com>
 <alpine.LRH.2.21.1709090808200.15026@namei.org>
 <CAHC9VhQ3YRmk7k5DQO9zoGKRXi3CSTHvmRuLa891NVWsVNCZZA@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8b1ea069-2389-5298-c187-647202762d72@schaufler-ca.com>
Date: Tue, 6 Mar 2018 11:28:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQ3YRmk7k5DQO9zoGKRXi3CSTHvmRuLa891NVWsVNCZZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1577990101774039350?=
X-GMAIL-MSGID: =?utf-8?q?1594217748090035804?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/6/2018 11:01 AM, Paul Moore wrote:
> On Fri, Sep 8, 2017 at 6:09 PM, James Morris <jmorris@namei.org> wrote:
>> On Fri, 8 Sep 2017, Paul Moore wrote:
>>> Looks fine to me from a SELinux perspective.  If Casey and John are
>>> happy with this I can volunteer to pull it into the selinux/next tree
>>> (once the merge window closes), otherwise if someone else wants to
>>> merge this my ack is below.
>> As this impacts multiple LSMs, I'd prefer to take it via my tree.
> What happened to this James?  As best I can tell there were never any
> objections, and plenty of ACKs, but I don't see it in Linus' tree.
> I'll extend my offer to merge it, but I know you expressed a desire to
> pull this via your tree.

I was also surprised that it had not been included.

>
> * http://kernsec.org/pipermail/linux-security-module-archive/2017-September/003156.html
>

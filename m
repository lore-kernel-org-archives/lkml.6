Return-Path: <kernel-hardening-return-11559-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x2252OrVwx0MkIeowQRh1aNDYWSZ4XrvxIA/Y1NxQAl6AUyVRmZxddURqcDGpvOQXDY4HYVk/
ARC-Seal: i=1; a=rsa-sha256; t=1517597024; cv=none;
        d=google.com; s=arc-20160816;
        b=pqPnN6Ebf98/iV6G3ilGWBwhfxvqBq4NFWbI4wXX7PtgajRyg/6/F5j0OmfP1Ry6JI
         0DQ1uWxzPkVqyAVJ/q7PY49Ejv7VG006ouFvaHQ6xQcXJycOC3Xs+Igm4VCCSfkor7He
         7cjtO+Tllv8MTIE+QP6fGfbmNr1dIqA1hAUGKBGFtibG7YmLJrDv0JZ9k4VXxOajjs/d
         7dldAffMD1AqMlWhP+jDhaztncLBGMfqR8DfB7r2ymBD5QNyqMx7jX/DgVf1ZrxStOPe
         HD5ZblI0QWEPsQmVMe8M+mUXjECH0Fv/e8i312H5rHq1zZwCGyJfsB6y8r5N+c+TOAZ1
         RpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=yoPxrHUY0rZcG2r5nYUWo4LZXYlS5e3I/rpWq33ONjQ=;
        b=QMzlzybW6q7K9zwHxNoDuWERc2AgofW5UNtAeAHmKvIOv5uZ7gyzEzhw5SBuvlF/XE
         q0T+ctFKfxVDzWbUGXVwdxxb7PJzJ5hjqr2c0RdPFD1GwJvU8y1JOcsMwJVyPlKVPKEv
         4iwH4spjfmMr6tDSD1kek06R5wOxsCw7lgyFHceBXwB+eP1uwNiOdBn0m6uZyUk7WZsj
         UNeylPzHa7+u4PffQZvmuQxnYC65i8Yitsrr6+FV2Jy7mRE62zCFeisnJqU99xhSvmhD
         m8Y5hggt+OVUnk2AryvpbZxY/vIkht490yKPYrzlSPTOXQmw37XjRf7tDfl3aW2I4e62
         JLtw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11559-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11559-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11559-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11559-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 2 Feb 2018 12:43:25 -0600 (CST)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Igor Stoppa <igor.stoppa@huawei.com>
cc: jglisse@redhat.com, keescook@chromium.org, mhocko@kernel.org,
    labbott@redhat.com, hch@infradead.org, willy@infradead.org,
    linux-security-module@vger.kernel.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 3/6] struct page: add field for vm_struct
In-Reply-To: <48fde114-d063-cfbf-e1b6-262411fcd963@huawei.com>
Message-ID: <alpine.DEB.2.20.1802021240370.31548@nuc-kabylake>
References: <20180130151446.24698-1-igor.stoppa@huawei.com> <20180130151446.24698-4-igor.stoppa@huawei.com> <alpine.DEB.2.20.1801311758340.21272@nuc-kabylake> <48fde114-d063-cfbf-e1b6-262411fcd963@huawei.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfID9mcQf5JMNc6oCJQJ4mHhLBY4baydYAg54LAGvNcUhnye5RaU87Tp818gpsexinIDGJF916t7kLaleryOLd7kjpAxgRICfNWhcV9FvYRWf7z1lCX9P
 wZfVEc3xzVCoi3qyeP3fTRzmuHZ6J8tUTVEnjqlCC9N7+vKPNMC6btJSl5AqZgVKtASAvSuRsskemRU8FWgSPSSsCZMeHMnYAxiSnbTTw18KZtRSsc3MpfOV
 Pez5EkOHe8zZYF8dCdzFGLG1QmDozOgypFSMF+eCV6QgySl8iZYu0bnsHqmvqy1TFdKrJMyYpnEweeyONwjC5EiSkKqUV5/a6bXqS9oLn1RVY0BtHJdjQw/Z
 g3++ftmXvd/siqAJxNQGryE8i/2qIpfFo4riJRNSoC2c5iBVjKAB4oP/I8gnVo5PBAsSe6mJf4LKViFa/IJy9KOmbxesp8qE/bSe3QlhgfcSPhj0x1OmBaTR
 Hp8gH5m5CB8JbpK7hbInyda2MEWbWCSsLDMU0xOTMaN8dblAbAONIBqQDwE=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591031026595146297?=
X-GMAIL-MSGID: =?utf-8?q?1591315817233300375?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 1 Feb 2018, Igor Stoppa wrote:

> > Would it not be better to use compound page allocations here?
> > page_head(whatever) gets you the head page where you can store all sorts
> > of information about the chunk of memory.
>
> Can you please point me to this function/macro? I don't seem to be able
> to find it, at least not in 4.15

Ok its compound_head(). See also the use in the SLAB and SLUB allocator.

> During hardened user copy permission check, I need to confirm if the
> memory range that would be exposed to userspace is a legitimate
> sub-range of a pmalloc allocation.

If you save the size in the head page struct then you could do that pretty
fast.

> I cannot comment on your proposal because I do not know where to find
> the reference you made, or maybe I do not understand what you mean :-(

compund pages are higher order pages that are handled as a single page by
the VM. See https://lwn.net/Articles/619514/

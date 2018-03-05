Return-Path: <elfring@users.sourceforge.net>
X-Google-Smtp-Source: AG47ELvzxpGUo7tvZ5AqJUR6mFBGMGDqAnVQihjdtkZDjTBOLBS1+iZpcaKD0bL7jlPBW1QuXE2O
ARC-Seal: i=1; a=rsa-sha256; t=1520266769; cv=none;
        d=google.com; s=arc-20160816;
        b=HVf9BXT5u/ND5hBuWCg/YmiHtvVhumH+8rsnfS8cOb4g+L7pUzg19kMehj9zDyN+5W
         8qErhlL3Fe8k54zmKVTUieTkHN+FY0kIWI/d0KagX7RLoLOpOhXLNuMGP9vBpClDc28A
         bOXzIY7u+Kt4xz1Ac87ilNHeBgWisTXEzgus7YgDLijnZkJmy1TM2GRR+obQb2ralPm6
         tdlD41FkM/GGa2/GVm0gT14u9NhTDz80zgF5D48p3wohvEEjXwSg6W07QNK4DvsuskPp
         A1j1jv+4gMXHB8MXrpI1mgjP70uwWTWRaWTScFzdBs1Ylu2+1c0sZ+SLDRq1rwasi+NW
         yALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:arc-authentication-results;
        bh=sX0Vxz1FDbN/B8PDRAzr2kHn5gDmzotRefHPSNDiBYA=;
        b=wa3RSb63TGjb1207+QDcg1tXjvaxG+vBFBieoCvOWUz6WcGOBKnygQvV5Agg9z/5wr
         KFoavV47BJh+AZgoGBJJtLksQsfqT6665Ry/37kIEtSsDJsSNHpWnfNLzpg3uIBkWUiu
         F46TifbKRxnlZJgypLrRoeZ1rjzvy2lNgYrnM0jG+yyGmmrbmZF5AAETRlelNBxf9mOS
         KKCL2i1e5rFih7+DnZISxS9qh0DIHhPje7/V+Wdcg2UfDJneKi0CTnSPY4A5v9PqyGCK
         5uFm8fvh+ZQwskfBya+26afATWG/+VLs4seVRdpivjjGArG6xwBjGTO5JPLGD3lgZvKk
         OxKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of elfring@users.sourceforge.net designates 217.72.192.78 as permitted sender) smtp.mailfrom=elfring@users.sourceforge.net;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=sourceforge.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of elfring@users.sourceforge.net designates 217.72.192.78 as permitted sender) smtp.mailfrom=elfring@users.sourceforge.net;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=sourceforge.net
To: kernel-janitors@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 George Zhang <georgezhang@vmware.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy King <acking@vmware.com>,
 Dmitry Torokhov <dtor@vmware.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] VMCI: Adjustments for three function implementations
Message-ID: <66411a1a-fd12-dc31-fc2e-800ff6cea1ed@users.sourceforge.net>
Date: Mon, 5 Mar 2018 17:19:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:VSv8qMdeS6LahgsiE/NfwtlYIr7vqHRkIVc58fbbj7G8wHuFJZh
 KY3UC1zhNSl5UAO1mHS0r7Qf9SsKo8NgP3JNQgpGNp16wYl4FAF0HjTOx+IAL85r9FcDQJS
 azo+/mv5TzlzVDlPjJl4hgHD07tUDxrEjbC9+AYtczT13ywd/pZWhrUp2MGtbHSkC858ufA
 wTfTDZ4mircIeXGT3OBnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HDNTndxFNjA=:Z1ABxASDyIXUdeYVQfg/y9
 u+NmR8AtLiLeto4MN84nFlhJbRoumC2m9MnSmw6LoeqWBilkL4Z8U/Mf0QhbNWscJAUFgdBXz
 qrZkpsqMKNLVYdc6icaTjjgJy5Ce7cgizrVeFahGkX71xAeAripuOP+yWBp4dXsx5gm+FfQQ/
 dbkGhnmm5C56AVMfxaDUx8Rke0C84XWsYRePS19kEl0XTZWBWZvS+2Vdh+oepvNHulEP4mKoi
 4PywrHC86UaPcDXY5yICFAL/MqyWT0QRt3zgkIZrcMP8pYBW/E2/t3/c+Cg+WjB44Cu7R39or
 MBbLuhiSw3PgJlCULoOcJvgl83nfIveehg7AMraKk9E4gRZNQyjBgBeQA6oguA5QmZpMOrwfZ
 fDvo2FGdEsqWyqDVt/1xJbQuGigOFfWMIardafTa1FoyZJIXg/Y84DRcJWMYWWu3vGNU37oz7
 yGpxcKzIAt7aDmg/MHok+Keb6UkShAfEQIyoyw6GEdXQZWj5iT44tKnTB1hk2eKavhYHtDGHR
 /LqjYqTFvkYXGfzQt8vuLn9v89Y0D7zyy5lYfiOFb3eDmV8exX+ihEmQSuO14m40NnpAKFIDs
 dYlzj/y56EaninGAR5OZa9Vg+5SpVbISrzlMikFr1b+H1k7xUdKI7yjuuUwdHRjvFt5pi0FXY
 koSQWt/GFsKaZUdD4viJW2o2e0nRgB/Xn07JdWtq2F6/RzyEL0ssFskJ4MPko2HU1YSpRuFHi
 TvgnKpcXN2r/OYWbeitj2UBD1/tnMD2JQsv84bf5g2fo2+ut1q/0HyZzZOyROjZ53Bbxzge6W
 FZX5+BNIjNR1afK+qNXqSWZ41c2W1uV+M8HYYLzh0rnl4tVUmc=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594115248801460604?=
X-GMAIL-MSGID: =?utf-8?q?1594115248801460604?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Mar 2018 17:12:34 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Use memdup_user() rather than duplicating its implementation
  Improve a size determination in two functions

 drivers/misc/vmw_vmci/vmci_context.c |  2 +-
 drivers/misc/vmw_vmci/vmci_host.c    | 21 +++++----------------
 2 files changed, 6 insertions(+), 17 deletions(-)

-- 
2.16.2

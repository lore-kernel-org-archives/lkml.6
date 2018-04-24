Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934404AbeDXNpu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:45:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47656 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933774AbeDXNpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:45:10 -0400
Date: Tue, 24 Apr 2018 09:44:15 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <588983c3-4ceb-071e-260b-869613655951@redhat.com>
References: <24cd527d-5287-f0be-ffe8-eab341bf1d94@redhat.com> <3866d359-0ef8-6a99-6254-84890be62b93@redhat.com> <20180226122205.GG4377@pd.tnic> <fb705c01-9bdd-9924-00c6-70d8ee940fb4@redhat.com> <CANRm+CyyL2jjjn7nZtLJvP+t1pN9ndAGhijmbX4LJh15=O+dvQ@mail.gmail.com> <20180417202417.GA29865@localhost.localdomain> <CANRm+CwA22VmpA5cfQg8mF_Xke_hXtP+_ui5xU+LV8v0JNj=3Q@mail.gmail.com> <20180418090329.GJ29865@localhost.localdomain> <de059c45-d706-ff70-9063-92ac0a807e26@redhat.com> <CANRm+CzxG5cm8ECopzGYpF3E3RTjvFGD3_7o8S=tffFxnvYoiA@mail.gmail.com> <20180424031400.GA22608@char.us.oracle.com> <588983c3-4ceb-071e-260b-869613655951@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
To: Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li <kernellwp@gmail.com>
CC: Eduardo Habkost <ehabkost@redhat.com>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <2944C5CC-A3AF-4B33-B03F-7EC28FC351CB@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8872 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=670
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804240131
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3ODjsRb004122

On April 24, 2018 1:09:00 AM EDT, Paolo Bonzini <pbonzini@redhat.com> wrote:
>On 24/04/2018 05:14, Konrad Rzeszutek Wilk wrote:
>> You would need to include the microcode version in the migration
>stream.
>> 
>> But this brings another point - what if we want to manifest certain
>> new CPUID bits?
>
>You don't do that across migration.  Generally if you want to do live
>migration and you set up the guest to know everything about the host
>(down to the microcode level), you should make sure your host are
>pretty
>much identical.

I understand how it ought to be but sadly the cloud vendors have a mix of hardware.


With the retpoline/IBRS support (like what RH kernel has) you could migrate from Skylake to Broadwell and switching over from IBRS to retpoline would be good.

Hence asking about this.

>
>Paolo

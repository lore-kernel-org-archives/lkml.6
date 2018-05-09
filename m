Return-Path: <linux_dti@icloud.com>
X-Google-Smtp-Source: AB8JxZoh0v41VQuNdxQRwQNhsgNlsrQZG6tfqHdLS2d3PjkREMqtUwMTiiK8Qvv8JPjl9H0IoY1b
ARC-Seal: i=1; a=rsa-sha256; t=1525897096; cv=none;
        d=google.com; s=arc-20160816;
        b=HIwpROL2VHZSDfGaOHGUnBVUr3+/hBB7Ff9gvpKItYZvabH9tAUCKFf+pvYAdVuy0l
         a31ygdCkvy9BhgKsoM5K1mPltSs99rPRFtWCYuyybCkM1TKQIidtWIGpTiyIGxAUAS5V
         naEwCT3uJUjaND8OiOju/ZAfYQp1d4PHz1fJEzuvXNNdGubliUAlj9UELx9O+lAK2Ogp
         1JLS2kQ4XOMrIhON00QCzQcwU7FsXP154Yx5lcyMesDurxwmPPYpeh5pTz34UBzYIEXA
         9u1BTWvCBdW97W4BdxpNb8Fo0cShMhF8VDR3qE8I5c8WsGavZlzPUG8UDhQO+BJI9gNT
         tfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:mail-followup-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=LGFeZSYpnilU22n1dPBy27tbGv8z/OfUi1CD4HLGcqs=;
        b=i0mTbIwqtdDWR0SHxPwcg1oG7axuZAiFntjdrBhjPMJogu11nApIzScp85Vx5Irbaz
         NJa16Ir+pUcFk82fVufek9QPpvHM9vEfXA6QgsJOBzZgROQPBJlEtUcGUz46NnF3w9iC
         +Y2kz2UZK8+gdj6zcFUGxVPsRrSZCajwdkT734DIdglTDXIYWeqQauPnZDftHjhoucdI
         kvBXaFwgvUPO9Q8dQbz1dL/EWgl4V19jCgmSfWchwnUXg5eKSQwWduBTtUU+x4fIcjKF
         HrSWkXbUi/btd5b6wFVsYv/rQvT4mrT3EYz7PD3Z7TE0UjZ5bjq3aJQx0SYJ3rzv619L
         EjyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@icloud.com header.s=04042017 header.b=O8vuIoYO;
       spf=pass (google.com: domain of linux_dti@icloud.com designates 17.58.37.19 as permitted sender) smtp.mailfrom=linux_dti@icloud.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=icloud.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@icloud.com header.s=04042017 header.b=O8vuIoYO;
       spf=pass (google.com: domain of linux_dti@icloud.com designates 17.58.37.19 as permitted sender) smtp.mailfrom=linux_dti@icloud.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=icloud.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-05-09_07:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1015 suspectscore=2 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1805090189
Date: Wed, 09 May 2018 22:18:04 +0200
From: damian <linux_dti@icloud.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: Bug in vboxguest: After commit Merge tag 'char-misc-4.17-rc3'
Message-id: <20180509201803.GA8982@zrhn9910b>
Mail-followup-to: Hans de Goede <hdegoede@redhat.com>,
 gregkh@linuxfoundation.org, arnd@arndb.de, linux-kernel@vger.kernel.org
References: <20180502193735.GA2444@zrhn9910b>
 <20180502200615.GB16341@kroah.com> <20180502204612.GA2089@zrhn9910b>
 <c589f2f9-e8e3-7f54-e1ab-9ac3baf700bf@redhat.com>
 <20180508194135.GA27020@zrhn9910b>
 <cbf215d0-b193-16fd-cfb7-b6cbf4dc6a74@redhat.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-disposition: inline
Content-transfer-encoding: 8bit
In-reply-to: <cbf215d0-b193-16fd-cfb7-b6cbf4dc6a74@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599382342256929089?=
X-GMAIL-MSGID: =?utf-8?q?1600019073562320427?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 09. May 09:36, Hans de Goede wrote:
> Hi,
> 
> On 08-05-18 21:41, damian wrote:
> >On Tue, 08. May 13:42, Hans de Goede wrote:
> >>Hi Damian,
> >>
> >>On 02-05-18 22:46, damian wrote:
> >>>Hello Greg,
> >>>
> >>>it is PATCH 3 virt: vbox: Use __get_free_pages insteas of kmalloc for DMA32 memory.
> >>
> >>Thank you for the bug report, I've tried to reproduce this problem
> >>but for me everything works fine.
> >>
> >>Does your virtual-machine have more then 4G of RAM configured for its
> >>use?  If yes then what is likely happening is that you also have
> >>the out-of-tree version of the vboxguest modules installed and prior
> >>to the commit in question the out of tree version of the driver is
> >>loading, because before that commit the vboxguest driver in the
> >>mainline kernel fails to load on machines with more then 4G.
> >>
> >>Or alternatively before the commit in question you may not have
> >>any version of the vboxguest driver loaded.
> >>
> >>Using the upstream version of the driver should not make a noticeable
> >>difference, but before the vboxguest driver became a part of the
> >>mainline kernel the virtualbox upstream developers have done a
> >>cleanup / redesign of the userspace API of the vboxguest driver,
> >>so the vboxguest driver will only work with recent virtualbox-guest-additions
> >>and since you are using Ubuntu 16.04 chances are that you are
> >>using that with Ubuntu's quite old bundled virtualbox-guest-additions
> >>which will not work with the new driver and may be causing this
> >>issue.
> >>
> >>Can you try upgrading your virtualbox-guest-additions to 5.2.10
> >>please?
> >>
> >>Also if the above does not help, a couple of follow up
> >>questions to help this pin down further:
> >>
> >>1) Are you using vbox's 3d pass through functionality
> >>2) Which desktop-environment are you using?
> >>
> >>Regards,
> >>
> >>Hans
> >
> >Hi Hans,
> >
> >i will check my configutation and will come back
> >At the moment i dont use use the virtualbox-guest-additions, i use the driver from the staging area.
> 
> Ah I see, you may still have the Ubuntu pkg for them installed though,
> which may be an old version which actually starts to try and do stuff
> now that there is a vboxguest driver in mainline too, but that old
> version does not support the new, stable API as merged into the
> mainline.
> 
> So if you don't care about the add-ons instead of upgrading yopu
> can also remove the Ubuntu pkg for them.
> 
> Regards,
> 
> Hans

Hello Hans,

the reason why i dont use the virtual-guest-additions from virtualbox is the following with kernel 4.14rc4:

there are changes in the kernel and this need time to fix in virtualbox. 


  CC [M]  /opt/VBoxGuestAdditions-5.2.97/src/vboxguest-5.2.97/vboxvideo/vbva_base.o
/opt/VBoxGuestAdditions-5.2.97/src/vboxguest-5.2.97/vboxvideo/vbox_ttm.c: In Funktion »vbox_ttm_tt_create«:
/opt/VBoxGuestAdditions-5.2.97/src/vboxguest-5.2.97/vboxvideo/vbox_ttm.c:219:22: Fehler: Übergabe des Arguments 2 von »ttm_tt_init« von inkompatiblem Zeigertyp [-Werror=incompatible-pointer-types]
  if (ttm_tt_init(tt, bdev, size, page_flags, dummy_read_page)) {
                      ^~~~
In file included from /home/damian/kernel/linux/include/drm/ttm/ttm_bo_driver.h:45,
                 from /opt/VBoxGuestAdditions-5.2.97/src/vboxguest-5.2.97/vboxvideo/vbox_drv.h:69,
                 from /opt/VBoxGuestAdditions-5.2.97/src/vboxguest-5.2.97/vboxvideo/vbox_ttm.c:31:
/home/damian/kernel/linux/include/drm/ttm/ttm_tt.h:161:63: Anmerkung: »struct ttm_buffer_object *« erwartet, aber Argument hat Typ »struct ttm_bo_device *«
 int ttm_tt_init(struct ttm_tt *ttm, struct ttm_buffer_object *bo,
                                     ~~~~~~~~~~~~~~~~~~~~~~~~~~^~
/opt/VBoxGuestAdditions-5.2.97/src/vboxguest-5.2.97/vboxvideo/vbox_ttm.c:219:6: Fehler: zu viele Argumente für Funktion »ttm_tt_init«
  if (ttm_tt_init(tt, bdev, size, page_flags, dummy_read_page)) {
      ^~~~~~~~~~~
In file included from /home/damian/kernel/linux/include/drm/ttm/ttm_bo_driver.h:45,
                 from /opt/VBoxGuestAdditions-5.2.97/src/vboxguest-5.2.97/vboxvideo/vbox_drv.h:69,
                 from /opt/VBoxGuestAdditions-5.2.97/src/vboxguest-5.2.97/vboxvideo/vbox_ttm.c:31:
/home/damian/kernel/linux/include/drm/ttm/ttm_tt.h:161:5: Anmerkung: hier deklariert
 int ttm_tt_init(struct ttm_tt *ttm, struct ttm_buffer_object *bo,
     ^~~~~~~~~~~

Best regards
Damian

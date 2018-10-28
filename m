Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AA5ECDE47
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 09:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CC620870
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 09:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcdGZJLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CC620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeJ1S2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 14:28:38 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:43839 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeJ1S2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 14:28:38 -0400
Received: by mail-wr1-f48.google.com with SMTP id t10-v6so5424239wrn.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 02:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:from:subject:to:message-id:date:user-agent:mime-version
         :content-language;
        bh=S8mhazmooBoll9IWTQRoA9NrGscvrsvOuZvVh3sJHj0=;
        b=ZcdGZJLlqW+ngzvtV2v+U9OgjWlvnbidr0pclBGIwc2g4j5Bm7nFHGMEQjeWG/4sLa
         Btd8Uf7drA1LS920vj1fIP/MDDYgaUj6BLevqDx95gkZMIDvU9jY+7fztY7VTM1mhjAs
         czcm3ddWrtuPxIBIv13dVeTUzZlq4uZtq1DCHr3TlEM/AHBU2KTLLfgeRcJ4ee0SqGUe
         U7PwOmNMRUohIFj7wHnD/8rvlxWnMSe0Ow3V1bvKXbiCz8paRggzldHs3jO4ZgISzEpA
         fFGXmNkc2pbSr4+SohMqoYcHOMEGNufqaQcc2u1/ujBHxKfJw5SJDn0axfYn7WjDZWrw
         e5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:from:subject:to:message-id:date
         :user-agent:mime-version:content-language;
        bh=S8mhazmooBoll9IWTQRoA9NrGscvrsvOuZvVh3sJHj0=;
        b=XN0oma5dO8qFk2ssKrdudPGv5NbCF97t9Q0THLE4/a6UnZcBlo267G5Y8ylPxRoHfV
         Azcb3SNBoKpebdD5D/JbRRN9M+Ov3sFqO6zBfAQGpwmJakYJ8fsC1RT5YkJvpY+kV49l
         iXxJ/9UFysDtg2rCHS/fInQTbGCxHF2BmRwgNQ9sCRX8hgtagazhOmkiigJfjyNJFV+Q
         7TFAvMd+s39jjEOR7zd+1dtagrSTOS3GIB2SfDxVmW7D08MUAMOxMCEiMSZIjzNbuN8y
         SMMyrBU+s7fXdUv7WOoHmYcMCqpudeLAz7485zaHHgzXOkIirsLGfJ90+SChFlPds7yC
         7GKg==
X-Gm-Message-State: AGRZ1gLaau0siA0mKg1b/BkB/IZvalQV/s4PQCgHeOuK7YAEQikPG09N
        jIeoWtqsamo877XdRWvHc2HxdYEE
X-Google-Smtp-Source: AJdET5dj02lQ63fvKzvnN57EXC1YyOGhD8bQzt07SzifMKmnRo/C2ZSrKGGf/MFsYeZvMbfMqC8iJQ==
X-Received: by 2002:adf:bace:: with SMTP id w14-v6mr7390935wrg.203.1540719865233;
        Sun, 28 Oct 2018 02:44:25 -0700 (PDT)
Received: from [192.168.1.157] (host109-149-124-94.range109-149.btcentralplus.com. [109.149.124.94])
        by smtp.gmail.com with ESMTPSA id 11-v6sm9575262wmw.31.2018.10.28.02.44.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 02:44:24 -0700 (PDT)
Reply-To: tjcw@cantab.net
From:   Chris Ward <tjcw01@gmail.com>
Subject: Realtek wifi adapter
To:     linux-kernel@vger.kernel.org
Message-ID: <afcedf77-a21c-ebb0-77be-d8b886d6cf7f@gmail.com>
Date:   Sun, 28 Oct 2018 09:44:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------047F8824A8BBCF3045EA5114"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------047F8824A8BBCF3045EA5114
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Does anyone want to add 
https://www.amazon.co.uk/gp/product/B07C4JQZSP/ref=oh_aui_detailpage_o00_s01?ie=UTF8&psc=1 
to the set of modules built with the Linux kernel ?

I recently bought one of these. It came with source code for a Linux 
kernel driver, but it didn't work with the latest OpenSuSE Tumbleweed 
kernel, so I developed a patch (attached) to fix it. OpenSuSE Tumbleweed 
is only a few weeks behind the kernel.org 'latest', so shouldn't be too 
hard to integrate with the bleeding edge kernel.

You can take my patch as GPL2 or later, and I presume the 
RealTek-supplied code is GPL2; it is in the package from Amazon, or you 
can email me (tjcw at cantab.net) if you want a copy from me.

-- 
Chris Ward


--------------047F8824A8BBCF3045EA5114
Content-Type: text/x-patch;
 name="tw-20181022.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="tw-20181022.patch"

diff --git a/LICENSE b/LICENSE
deleted file mode 100644
index 7a8e8ab..0000000
--- a/LICENSE
+++ /dev/null
@@ -1,340 +0,0 @@
-		    GNU GENERAL PUBLIC LICENSE
-		       Version 2, June 1991
-
- Copyright (C) 1989, 1991 Free Software Foundation, Inc.
- 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA
- Everyone is permitted to copy and distribute verbatim copies
- of this license document, but changing it is not allowed.
-
-			    Preamble
-
-  The licenses for most software are designed to take away your
-freedom to share and change it.  By contrast, the GNU General Public
-License is intended to guarantee your freedom to share and change free
-software--to make sure the software is free for all its users.  This
-General Public License applies to most of the Free Software
-Foundation's software and to any other program whose authors commit to
-using it.  (Some other Free Software Foundation software is covered by
-the GNU Library General Public License instead.)  You can apply it to
-your programs, too.
-
-  When we speak of free software, we are referring to freedom, not
-price.  Our General Public Licenses are designed to make sure that you
-have the freedom to distribute copies of free software (and charge for
-this service if you wish), that you receive source code or can get it
-if you want it, that you can change the software or use pieces of it
-in new free programs; and that you know you can do these things.
-
-  To protect your rights, we need to make restrictions that forbid
-anyone to deny you these rights or to ask you to surrender the rights.
-These restrictions translate to certain responsibilities for you if you
-distribute copies of the software, or if you modify it.
-
-  For example, if you distribute copies of such a program, whether
-gratis or for a fee, you must give the recipients all the rights that
-you have.  You must make sure that they, too, receive or can get the
-source code.  And you must show them these terms so they know their
-rights.
-
-  We protect your rights with two steps: (1) copyright the software, and
-(2) offer you this license which gives you legal permission to copy,
-distribute and/or modify the software.
-
-  Also, for each author's protection and ours, we want to make certain
-that everyone understands that there is no warranty for this free
-software.  If the software is modified by someone else and passed on, we
-want its recipients to know that what they have is not the original, so
-that any problems introduced by others will not reflect on the original
-authors' reputations.
-
-  Finally, any free program is threatened constantly by software
-patents.  We wish to avoid the danger that redistributors of a free
-program will individually obtain patent licenses, in effect making the
-program proprietary.  To prevent this, we have made it clear that any
-patent must be licensed for everyone's free use or not licensed at all.
-
-  The precise terms and conditions for copying, distribution and
-modification follow.
-
-		    GNU GENERAL PUBLIC LICENSE
-   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
-
-  0. This License applies to any program or other work which contains
-a notice placed by the copyright holder saying it may be distributed
-under the terms of this General Public License.  The "Program", below,
-refers to any such program or work, and a "work based on the Program"
-means either the Program or any derivative work under copyright law:
-that is to say, a work containing the Program or a portion of it,
-either verbatim or with modifications and/or translated into another
-language.  (Hereinafter, translation is included without limitation in
-the term "modification".)  Each licensee is addressed as "you".
-
-Activities other than copying, distribution and modification are not
-covered by this License; they are outside its scope.  The act of
-running the Program is not restricted, and the output from the Program
-is covered only if its contents constitute a work based on the
-Program (independent of having been made by running the Program).
-Whether that is true depends on what the Program does.
-
-  1. You may copy and distribute verbatim copies of the Program's
-source code as you receive it, in any medium, provided that you
-conspicuously and appropriately publish on each copy an appropriate
-copyright notice and disclaimer of warranty; keep intact all the
-notices that refer to this License and to the absence of any warranty;
-and give any other recipients of the Program a copy of this License
-along with the Program.
-
-You may charge a fee for the physical act of transferring a copy, and
-you may at your option offer warranty protection in exchange for a fee.
-
-  2. You may modify your copy or copies of the Program or any portion
-of it, thus forming a work based on the Program, and copy and
-distribute such modifications or work under the terms of Section 1
-above, provided that you also meet all of these conditions:
-
-    a) You must cause the modified files to carry prominent notices
-    stating that you changed the files and the date of any change.
-
-    b) You must cause any work that you distribute or publish, that in
-    whole or in part contains or is derived from the Program or any
-    part thereof, to be licensed as a whole at no charge to all third
-    parties under the terms of this License.
-
-    c) If the modified program normally reads commands interactively
-    when run, you must cause it, when started running for such
-    interactive use in the most ordinary way, to print or display an
-    announcement including an appropriate copyright notice and a
-    notice that there is no warranty (or else, saying that you provide
-    a warranty) and that users may redistribute the program under
-    these conditions, and telling the user how to view a copy of this
-    License.  (Exception: if the Program itself is interactive but
-    does not normally print such an announcement, your work based on
-    the Program is not required to print an announcement.)
-
-These requirements apply to the modified work as a whole.  If
-identifiable sections of that work are not derived from the Program,
-and can be reasonably considered independent and separate works in
-themselves, then this License, and its terms, do not apply to those
-sections when you distribute them as separate works.  But when you
-distribute the same sections as part of a whole which is a work based
-on the Program, the distribution of the whole must be on the terms of
-this License, whose permissions for other licensees extend to the
-entire whole, and thus to each and every part regardless of who wrote it.
-
-Thus, it is not the intent of this section to claim rights or contest
-your rights to work written entirely by you; rather, the intent is to
-exercise the right to control the distribution of derivative or
-collective works based on the Program.
-
-In addition, mere aggregation of another work not based on the Program
-with the Program (or with a work based on the Program) on a volume of
-a storage or distribution medium does not bring the other work under
-the scope of this License.
-
-  3. You may copy and distribute the Program (or a work based on it,
-under Section 2) in object code or executable form under the terms of
-Sections 1 and 2 above provided that you also do one of the following:
-
-    a) Accompany it with the complete corresponding machine-readable
-    source code, which must be distributed under the terms of Sections
-    1 and 2 above on a medium customarily used for software interchange; or,
-
-    b) Accompany it with a written offer, valid for at least three
-    years, to give any third party, for a charge no more than your
-    cost of physically performing source distribution, a complete
-    machine-readable copy of the corresponding source code, to be
-    distributed under the terms of Sections 1 and 2 above on a medium
-    customarily used for software interchange; or,
-
-    c) Accompany it with the information you received as to the offer
-    to distribute corresponding source code.  (This alternative is
-    allowed only for noncommercial distribution and only if you
-    received the program in object code or executable form with such
-    an offer, in accord with Subsection b above.)
-
-The source code for a work means the preferred form of the work for
-making modifications to it.  For an executable work, complete source
-code means all the source code for all modules it contains, plus any
-associated interface definition files, plus the scripts used to
-control compilation and installation of the executable.  However, as a
-special exception, the source code distributed need not include
-anything that is normally distributed (in either source or binary
-form) with the major components (compiler, kernel, and so on) of the
-operating system on which the executable runs, unless that component
-itself accompanies the executable.
-
-If distribution of executable or object code is made by offering
-access to copy from a designated place, then offering equivalent
-access to copy the source code from the same place counts as
-distribution of the source code, even though third parties are not
-compelled to copy the source along with the object code.
-
-  4. You may not copy, modify, sublicense, or distribute the Program
-except as expressly provided under this License.  Any attempt
-otherwise to copy, modify, sublicense or distribute the Program is
-void, and will automatically terminate your rights under this License.
-However, parties who have received copies, or rights, from you under
-this License will not have their licenses terminated so long as such
-parties remain in full compliance.
-
-  5. You are not required to accept this License, since you have not
-signed it.  However, nothing else grants you permission to modify or
-distribute the Program or its derivative works.  These actions are
-prohibited by law if you do not accept this License.  Therefore, by
-modifying or distributing the Program (or any work based on the
-Program), you indicate your acceptance of this License to do so, and
-all its terms and conditions for copying, distributing or modifying
-the Program or works based on it.
-
-  6. Each time you redistribute the Program (or any work based on the
-Program), the recipient automatically receives a license from the
-original licensor to copy, distribute or modify the Program subject to
-these terms and conditions.  You may not impose any further
-restrictions on the recipients' exercise of the rights granted herein.
-You are not responsible for enforcing compliance by third parties to
-this License.
-
-  7. If, as a consequence of a court judgment or allegation of patent
-infringement or for any other reason (not limited to patent issues),
-conditions are imposed on you (whether by court order, agreement or
-otherwise) that contradict the conditions of this License, they do not
-excuse you from the conditions of this License.  If you cannot
-distribute so as to satisfy simultaneously your obligations under this
-License and any other pertinent obligations, then as a consequence you
-may not distribute the Program at all.  For example, if a patent
-license would not permit royalty-free redistribution of the Program by
-all those who receive copies directly or indirectly through you, then
-the only way you could satisfy both it and this License would be to
-refrain entirely from distribution of the Program.
-
-If any portion of this section is held invalid or unenforceable under
-any particular circumstance, the balance of the section is intended to
-apply and the section as a whole is intended to apply in other
-circumstances.
-
-It is not the purpose of this section to induce you to infringe any
-patents or other property right claims or to contest validity of any
-such claims; this section has the sole purpose of protecting the
-integrity of the free software distribution system, which is
-implemented by public license practices.  Many people have made
-generous contributions to the wide range of software distributed
-through that system in reliance on consistent application of that
-system; it is up to the author/donor to decide if he or she is willing
-to distribute software through any other system and a licensee cannot
-impose that choice.
-
-This section is intended to make thoroughly clear what is believed to
-be a consequence of the rest of this License.
-
-  8. If the distribution and/or use of the Program is restricted in
-certain countries either by patents or by copyrighted interfaces, the
-original copyright holder who places the Program under this License
-may add an explicit geographical distribution limitation excluding
-those countries, so that distribution is permitted only in or among
-countries not thus excluded.  In such case, this License incorporates
-the limitation as if written in the body of this License.
-
-  9. The Free Software Foundation may publish revised and/or new versions
-of the General Public License from time to time.  Such new versions will
-be similar in spirit to the present version, but may differ in detail to
-address new problems or concerns.
-
-Each version is given a distinguishing version number.  If the Program
-specifies a version number of this License which applies to it and "any
-later version", you have the option of following the terms and conditions
-either of that version or of any later version published by the Free
-Software Foundation.  If the Program does not specify a version number of
-this License, you may choose any version ever published by the Free Software
-Foundation.
-
-  10. If you wish to incorporate parts of the Program into other free
-programs whose distribution conditions are different, write to the author
-to ask for permission.  For software which is copyrighted by the Free
-Software Foundation, write to the Free Software Foundation; we sometimes
-make exceptions for this.  Our decision will be guided by the two goals
-of preserving the free status of all derivatives of our free software and
-of promoting the sharing and reuse of software generally.
-
-			    NO WARRANTY
-
-  11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
-FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
-OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
-PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
-OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
-MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
-TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
-PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
-REPAIR OR CORRECTION.
-
-  12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
-WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
-REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
-INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
-OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
-TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
-YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
-PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
-POSSIBILITY OF SUCH DAMAGES.
-
-		     END OF TERMS AND CONDITIONS
-
-	    How to Apply These Terms to Your New Programs
-
-  If you develop a new program, and you want it to be of the greatest
-possible use to the public, the best way to achieve this is to make it
-free software which everyone can redistribute and change under these terms.
-
-  To do so, attach the following notices to the program.  It is safest
-to attach them to the start of each source file to most effectively
-convey the exclusion of warranty; and each file should have at least
-the "copyright" line and a pointer to where the full notice is found.
-
-    <one line to give the program's name and a brief idea of what it does.>
-    Copyright (C) <year>  <name of author>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA
-
-
-Also add information on how to contact you by electronic and paper mail.
-
-If the program is interactive, make it output a short notice like this
-when it starts in an interactive mode:
-
-    Gnomovision version 69, Copyright (C) year name of author
-    Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
-    This is free software, and you are welcome to redistribute it
-    under certain conditions; type `show c' for details.
-
-The hypothetical commands `show w' and `show c' should show the appropriate
-parts of the General Public License.  Of course, the commands you use may
-be called something other than `show w' and `show c'; they could even be
-mouse-clicks or menu items--whatever suits your program.
-
-You should also get your employer (if you work as a programmer) or your
-school, if any, to sign a "copyright disclaimer" for the program, if
-necessary.  Here is a sample; alter the names:
-
-  Yoyodyne, Inc., hereby disclaims all copyright interest in the program
-  `Gnomovision' (which makes passes at compilers) written by James Hacker.
-
-  <signature of Ty Coon>, 1 April 1989
-  Ty Coon, President of Vice
-
-This General Public License does not permit incorporating your program into
-proprietary programs.  If your program is a subroutine library, you may
-consider it more useful to permit linking proprietary applications with the
-library.  If this is what you want to do, use the GNU Lesser General
-Public License instead of this License.
diff --git a/Linux/driver/rtl8821AU_WiFi_linux_v5.2.6.2_23547.20170814_COEX20170206-6760/hal/phydm/phydm_interface.c b/Linux/driver/rtl8821AU_WiFi_linux_v5.2.6.2_23547.20170814_COEX20170206-6760/hal/phydm/phydm_interface.c
index 9d67264..d3684d8 100644
--- a/Linux/driver/rtl8821AU_WiFi_linux_v5.2.6.2_23547.20170814_COEX20170206-6760/hal/phydm/phydm_interface.c
+++ b/Linux/driver/rtl8821AU_WiFi_linux_v5.2.6.2_23547.20170814_COEX20170206-6760/hal/phydm/phydm_interface.c
@@ -564,7 +564,7 @@ odm_set_timer(
 #if (DM_ODM_SUPPORT_TYPE & ODM_AP)
 	mod_timer(p_timer, jiffies + RTL_MILISECONDS_TO_JIFFIES(ms_delay));
 #elif (DM_ODM_SUPPORT_TYPE & ODM_CE)
-	_set_timer(p_timer, ms_delay); /* ms */
+	_set_timer((_timer *)p_timer, ms_delay); /* ms */
 #elif (DM_ODM_SUPPORT_TYPE & ODM_WIN)
 	struct _ADAPTER		*adapter = p_dm_odm->adapter;
 	PlatformSetTimer(adapter, p_timer, ms_delay);
@@ -588,7 +588,7 @@ odm_initialize_timer(
 	/*mod_timer(p_timer, jiffies+RTL_MILISECONDS_TO_JIFFIES(10));	*/
 #elif (DM_ODM_SUPPORT_TYPE & ODM_CE)
 	struct _ADAPTER *adapter = p_dm_odm->adapter;
-	_init_timer(p_timer, adapter->pnetdev, call_back_func, p_dm_odm);
+	_init_timer((_timer *)p_timer, adapter->pnetdev, call_back_func, p_dm_odm);
 #elif (DM_ODM_SUPPORT_TYPE & ODM_WIN)
 	struct _ADAPTER *adapter = p_dm_odm->adapter;
 	PlatformInitializeTimer(adapter, p_timer, call_back_func, p_context, sz_id);
@@ -605,7 +605,7 @@ odm_cancel_timer(
 #if (DM_ODM_SUPPORT_TYPE & ODM_AP)
 	del_timer(p_timer);
 #elif (DM_ODM_SUPPORT_TYPE & ODM_CE)
-	_cancel_timer_ex(p_timer);
+	_cancel_timer_ex((_timer *)p_timer);
 #elif (DM_ODM_SUPPORT_TYPE & ODM_WIN)
 	struct _ADAPTER *adapter = p_dm_odm->adapter;
 	PlatformCancelTimer(adapter, p_timer);
diff --git a/Linux/driver/rtl8821AU_WiFi_linux_v5.2.6.2_23547.20170814_COEX20170206-6760/include/osdep_service.h b/Linux/driver/rtl8821AU_WiFi_linux_v5.2.6.2_23547.20170814_COEX20170206-6760/include/osdep_service.h
index 4d7c1f0..55e9b7e 100644
--- a/Linux/driver/rtl8821AU_WiFi_linux_v5.2.6.2_23547.20170814_COEX20170206-6760/include/osdep_service.h
+++ b/Linux/driver/rtl8821AU_WiFi_linux_v5.2.6.2_23547.20170814_COEX20170206-6760/include/osdep_service.h
@@ -355,7 +355,7 @@ extern void rtw_init_timer(_timer *ptimer, void *padapter, void *pfunc);
 __inline static unsigned char _cancel_timer_ex(_timer *ptimer)
 {
 #ifdef PLATFORM_LINUX
-	return del_timer_sync(ptimer);
+	return del_timer_sync((struct timer_list *)ptimer);
 #endif
 #ifdef PLATFORM_FREEBSD
 	_cancel_timer(ptimer, 0);
diff --git a/Linux/driver/rtl8821AU_WiFi_linux_v5.2.6.2_23547.20170814_COEX20170206-6760/include/osdep_service_linux.h b/Linux/driver/rtl8821AU_WiFi_linux_v5.2.6.2_23547.20170814_COEX20170206-6760/include/osdep_service_linux.h
index 43fa41f..7379e8d 100644
--- a/Linux/driver/rtl8821AU_WiFi_linux_v5.2.6.2_23547.20170814_COEX20170206-6760/include/osdep_service_linux.h
+++ b/Linux/driver/rtl8821AU_WiFi_linux_v5.2.6.2_23547.20170814_COEX20170206-6760/include/osdep_service_linux.h
@@ -148,7 +148,14 @@ typedef	spinlock_t	_lock;
 #else
 	typedef struct semaphore	_mutex;
 #endif
-typedef struct timer_list _timer;
+// tjcw we need timer list to have a 'void *' as well
+struct _timer_entry {
+	struct timer_list t_list ;
+	void (*callback)(unsigned long) ;
+	unsigned long data ;
+} ;
+typedef struct _timer_entry _timer ;
+//typedef struct timer_list _timer;
 
 struct	__queue	{
 	struct	list_head	queue;
@@ -281,22 +288,30 @@ __inline static void rtw_list_delete(_list *plist)
 
 #define RTW_TIMER_HDL_ARGS void *FunctionContext
 
+// tjcw timer_list does not have 'data' any more. See what breaks without it.
+static void _timer_function(struct timer_list *ptimer)
+{
+	_timer *myptimer = (_timer *) ptimer ;
+	myptimer->callback(myptimer->data) ;
+}
 __inline static void _init_timer(_timer *ptimer, _nic_hdl nic_hdl, void *pfunc, void *cntx)
 {
 	/* setup_timer(ptimer, pfunc,(u32)cntx);	 */
-	ptimer->function = pfunc;
-	ptimer->data = (unsigned long)cntx;
-	init_timer(ptimer);
+//	ptimer->t_list.function = pfunc;
+	ptimer->callback=pfunc ;
+	ptimer->data = (unsigned long) cntx;
+//	init_timer((struct timer_list *)ptimer);
+	timer_setup((struct timer_list *)ptimer, _timer_function, 0);
 }
 
 __inline static void _set_timer(_timer *ptimer, u32 delay_time)
 {
-	mod_timer(ptimer , (jiffies + (delay_time * HZ / 1000)));
+	mod_timer((struct timer_list *)ptimer , (jiffies + (delay_time * HZ / 1000)));
 }
 
 __inline static void _cancel_timer(_timer *ptimer, u8 *bcancelled)
 {
-	del_timer_sync(ptimer);
+	del_timer_sync((struct timer_list *)ptimer);
 	*bcancelled = 1;
 }
 
diff --git a/Linux/driver/rtl8821AU_WiFi_linux_v5.2.6.2_23547.20170814_COEX20170206-6760/os_dep/linux/ioctl_cfg80211.c b/Linux/driver/rtl8821AU_WiFi_linux_v5.2.6.2_23547.20170814_COEX20170206-6760/os_dep/linux/ioctl_cfg80211.c
index 6d40a42..c6fbf96 100644
--- a/Linux/driver/rtl8821AU_WiFi_linux_v5.2.6.2_23547.20170814_COEX20170206-6760/os_dep/linux/ioctl_cfg80211.c
+++ b/Linux/driver/rtl8821AU_WiFi_linux_v5.2.6.2_23547.20170814_COEX20170206-6760/os_dep/linux/ioctl_cfg80211.c
@@ -737,24 +737,37 @@ check_bss:
 	if (rtw_to_roam(padapter) > 0) {
 		#if LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 39) || defined(COMPAT_KERNEL_RELEASE)
 		struct wiphy *wiphy = pwdev->wiphy;
+		struct cfg80211_roam_info roam_info = {} ;
 		struct ieee80211_channel *notify_channel;
 		u32 freq;
 		u16 channel = cur_network->network.Configuration.DSConfig;
 
 		freq = rtw_ch2freq(channel);
 		notify_channel = ieee80211_get_channel(wiphy, freq);
-		#endif
+		roam_info.channel = notify_channel;
+				roam_info.bssid = cur_network->network.MacAddress;
+				roam_info.req_ie =
+					pmlmepriv->assoc_req+sizeof(struct ieee80211_hdr_3addr)+2;
+				roam_info.req_ie_len =
+					pmlmepriv->assoc_req_len-sizeof(struct ieee80211_hdr_3addr)-2;
+				roam_info.resp_ie =
+					pmlmepriv->assoc_rsp+sizeof(struct ieee80211_hdr_3addr)+6;
+				roam_info.resp_ie_len =
+					pmlmepriv->assoc_rsp_len-sizeof(struct ieee80211_hdr_3addr)-6;
+				#endif
 
 		RTW_INFO(FUNC_ADPT_FMT" call cfg80211_roamed\n", FUNC_ADPT_ARG(padapter));
 		cfg80211_roamed(padapter->pnetdev
 			#if LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 39) || defined(COMPAT_KERNEL_RELEASE)
-			, notify_channel
-			#endif
+//			, notify_channel
+			, &roam_info
+            #else
 			, cur_network->network.MacAddress
 			, pmlmepriv->assoc_req + sizeof(struct rtw_ieee80211_hdr_3addr) + 2
 			, pmlmepriv->assoc_req_len - sizeof(struct rtw_ieee80211_hdr_3addr) - 2
 			, pmlmepriv->assoc_rsp + sizeof(struct rtw_ieee80211_hdr_3addr) + 6
 			, pmlmepriv->assoc_rsp_len - sizeof(struct rtw_ieee80211_hdr_3addr) - 6
+            #endif
 			, GFP_ATOMIC);
 #ifdef CONFIG_RTW_80211R
 		if ((rtw_to_roam(padapter) > 0) && rtw_chk_ft_flags(padapter, RTW_FT_SUPPORTED))
@@ -1739,7 +1752,8 @@ enum nl80211_iftype {
 #endif
 static int cfg80211_rtw_change_iface(struct wiphy *wiphy,
 				     struct net_device *ndev,
-				     enum nl80211_iftype type, u32 *flags,
+				     enum nl80211_iftype type,
+//					 u32 *flags,
 				     struct vif_params *params)
 {
 	enum nl80211_iftype old_type;
@@ -3818,7 +3832,7 @@ static int rtw_cfg80211_add_monitor_if(_adapter *padapter, char *name, struct ne
 	mon_ndev->type = ARPHRD_IEEE80211_RADIOTAP;
 	strncpy(mon_ndev->name, name, IFNAMSIZ);
 	mon_ndev->name[IFNAMSIZ - 1] = 0;
-	mon_ndev->destructor = rtw_ndev_destructor;
+	mon_ndev->priv_destructor = rtw_ndev_destructor;
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 29))
 	mon_ndev->netdev_ops = &rtw_cfg80211_monitor_if_ops;
@@ -3884,7 +3898,9 @@ static int
 		#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4, 1, 0))
 		unsigned char name_assign_type,
 		#endif
-		enum nl80211_iftype type, u32 *flags, struct vif_params *params)
+		enum nl80211_iftype type,
+//		u32 *flags,
+		struct vif_params *params)
 {
 	int ret = 0;
 	struct wireless_dev *wdev = NULL;
@@ -6762,7 +6778,7 @@ static void rtw_cfg80211_preinit_wiphy(_adapter *adapter, struct wiphy *wiphy)
 #endif
 
 #if defined(CONFIG_PM) && (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 0, 0))
-	wiphy->flags |= WIPHY_FLAG_SUPPORTS_SCHED_SCAN;
+//	wiphy->flags |= WIPHY_FLAG_SUPPORTS_SCHED_SCAN;
 #ifdef CONFIG_PNO_SUPPORT
 	wiphy->max_sched_scan_ssids = MAX_PNO_LIST_COUNT;
 #endif
diff --git a/Linux/driver/rtl8821AU_WiFi_linux_v5.2.6.2_23547.20170814_COEX20170206-6760/os_dep/osdep_service.c b/Linux/driver/rtl8821AU_WiFi_linux_v5.2.6.2_23547.20170814_COEX20170206-6760/os_dep/osdep_service.c
index 1fbea5d..927e00c 100644
--- a/Linux/driver/rtl8821AU_WiFi_linux_v5.2.6.2_23547.20170814_COEX20170206-6760/os_dep/osdep_service.c
+++ b/Linux/driver/rtl8821AU_WiFi_linux_v5.2.6.2_23547.20170814_COEX20170206-6760/os_dep/osdep_service.c
@@ -1988,7 +1988,7 @@ static int readFile(struct file *fp, char *buf, int len)
 
 	while (sum < len) {
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4, 1, 0))
-		rlen = __vfs_read(fp, buf + sum, len - sum, &fp->f_pos);
+		rlen = kernel_read(fp, buf + sum, len - sum, &fp->f_pos);
 #else
 		rlen = fp->f_op->read(fp, buf + sum, len - sum, &fp->f_pos);
 #endif
diff --git a/README.md b/README.md
index ac2d8c8..0dbe5d9 100644
--- a/README.md
+++ b/README.md
@@ -1,7 +1,7 @@
 # RTL8811AU
 
-This is the driver for a RealTek WiFi adapter, for OpenSuSE Leap 15.0 Linux. You should be using the leap-15.0 branch, so type 'git checkout leap-15.0' before proceeding.
+This is the driver for a RealTek WiFi adapter, for OpenSuSE Leap 15.0 Linux.
 
 To build this driver, first install the kernel-devel software package through YAST; then go to the Linux/driver/rtl* directory and type 'make'.
 
-To install the driver, in the same directory type 'sudo make install'.
+To install the driver, in the same directory type 'sudo make install'.
\ No newline at end of file

--------------047F8824A8BBCF3045EA5114--

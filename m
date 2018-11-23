Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE21CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F4720685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uta04sh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F4720685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbeKXH1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:27:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46943 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeKXH1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:27:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so13409874wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 12:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+FNa840Xsyyytn3lzYv44wwewd1L1W+80T/TSkXXnwI=;
        b=Uta04sh/j0YnG0Ek+c2nLh58wFrwcUOn2hKu8E0NQ6kZEHKiiTV6LluIflYUrjEpE6
         HFDcjBHNsdRWNkD9xVf3bHCiIcUAjIIWdRgBGIzrayk1dwodSmqnpzRN2u+1qGYLM2PN
         GaLf5QRueHZPhfkARkEBd9tULkoLq2gOOa9+pdviJmsycmz9Dw8/ErsM0E7Q90fWHGjR
         +eYwkQma8YZUBt6e082ibDLrpkPJ6n3B0nFD1565AvOO90j6PnPtCr+zN4CVQSDmbMT8
         ayf65osYKsK9KYOIjpmBMCWxO0WxmkLR6qW36g56ev2EKm9eyKMRVjgNLGBPvLFe/b/l
         aHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+FNa840Xsyyytn3lzYv44wwewd1L1W+80T/TSkXXnwI=;
        b=sqWYOcV2TOkhGAReMAF2mm3CK1GivCf/20dnKJJ2AiPe6FD2zdp4nuns0F5LCLWB10
         mph2Pdg3gxvPf1wJqSg/Z3BGAFZPRIETyFT1y0lpJgWJtRYParGAMvEXO8FSIHU7kx/y
         YLopUJyabBNDffsNw4LCg7mr8ZJ7oH73/xQqouigMuha7MoxYAkzxcM6qW4F7hepOqMe
         oFZRc5lonarRvJpEUbnU/UxwJyThDsJguggxcTmdjauP+n8kvouHa40s8kSG9tD/NVVP
         MTPH0KIFbGRllQ0tzCJ3ioXLpp1vH2S7TYcsR31uIUL1jdNj8btLVJHjB1wDXlH0LdRr
         uaqg==
X-Gm-Message-State: AA+aEWb6yIRqj+lYwCI5CzLB9XfCTtRQ2BshU1rrBsxGC7TC1s2REldZ
        eRI9ss7T6WFuNONRXvivy/4=
X-Google-Smtp-Source: AFSGD/XiW3bIZUJ6Q1GCACPeMMJfy2BzKMTtz3zetBd2Lbb5F0GOnbUvv/nmVhsPrqEM9/x0bvuOvA==
X-Received: by 2002:adf:8c09:: with SMTP id z9mr12839283wra.301.1543005682066;
        Fri, 23 Nov 2018 12:41:22 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id i9sm24598906wrs.34.2018.11.23.12.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 12:41:21 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/9] staging: rtl8188eu: cleanup declarations in rtw_mlme.c
Date:   Fri, 23 Nov 2018 21:41:02 +0100
Message-Id: <20181123204106.2284-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181123204106.2284-1-straube.linux@gmail.com>
References: <20181123204106.2284-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces, remove spaces, remove blank lines
and break lines appropriatly in declarations.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme.c | 130 +++++++++++-----------
 1 file changed, 64 insertions(+), 66 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index 54f05e62da49..9cc7d5b8293c 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -24,11 +24,11 @@ extern const u8 MCS_rate_1R[16];
 
 int rtw_init_mlme_priv(struct adapter *padapter)
 {
-	int	i;
-	u8	*pbuf;
-	struct wlan_network	*pnetwork;
-	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
-	int	res = _SUCCESS;
+	int i;
+	u8 *pbuf;
+	struct wlan_network *pnetwork;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	int res = _SUCCESS;
 
 	/*  We don't need to memset padapter->XXX to zero, because adapter is allocated by vzalloc(). */
 
@@ -179,7 +179,7 @@ void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *
 struct wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 {
 	struct list_head *phead, *plist;
-	struct	wlan_network *pnetwork = NULL;
+	struct wlan_network *pnetwork = NULL;
 	u8 zero_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
 
 	if (!memcmp(zero_addr, addr, ETH_ALEN)) {
@@ -259,7 +259,7 @@ u8 *rtw_get_capability_from_ie(u8 *ie)
 
 u16 rtw_get_capability(struct wlan_bssid_ex *bss)
 {
-	__le16	val;
+	__le16 val;
 
 	memcpy((u8 *)&val, rtw_get_capability_from_ie(bss->ies), 2);
 
@@ -327,8 +327,8 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst)
 struct	wlan_network	*rtw_get_oldest_wlan_network(struct __queue *scanned_queue)
 {
 	struct list_head *plist, *phead;
-	struct	wlan_network	*pwlan = NULL;
-	struct	wlan_network	*oldest = NULL;
+	struct wlan_network *pwlan = NULL;
+	struct wlan_network *oldest = NULL;
 
 	phead = get_list_head(scanned_queue);
 
@@ -402,11 +402,11 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *target)
 {
 	struct list_head *plist, *phead;
-	u32	bssid_ex_sz;
+	u32 bssid_ex_sz;
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	struct __queue *queue = &pmlmepriv->scanned_queue;
-	struct wlan_network	*pnetwork = NULL;
-	struct wlan_network	*oldest = NULL;
+	struct wlan_network *pnetwork = NULL;
+	struct wlan_network *oldest = NULL;
 
 	spin_lock_bh(&queue->lock);
 	phead = get_list_head(queue);
@@ -722,7 +722,7 @@ static void free_scanqueue(struct	mlme_priv *pmlmepriv)
  */
 void rtw_free_assoc_resources(struct adapter *adapter)
 {
-	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
 	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 	rtw_free_assoc_resources_locked(adapter);
@@ -735,8 +735,8 @@ void rtw_free_assoc_resources(struct adapter *adapter)
 void rtw_free_assoc_resources_locked(struct adapter *adapter)
 {
 	struct wlan_network *pwlan = NULL;
-	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
-	struct	sta_priv *pstapriv = &adapter->stapriv;
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
+	struct sta_priv *pstapriv = &adapter->stapriv;
 	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+rtw_free_assoc_resources\n"));
@@ -784,7 +784,7 @@ void rtw_free_assoc_resources_locked(struct adapter *adapter)
  */
 void rtw_indicate_connect(struct adapter *padapter)
 {
-	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+%s\n", __func__));
 
@@ -810,7 +810,7 @@ void rtw_indicate_connect(struct adapter *padapter)
  */
 void rtw_indicate_disconnect(struct adapter *padapter)
 {
-	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("+%s\n", __func__));
 
@@ -965,12 +965,12 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 {
 	struct sta_info *ptarget_sta = NULL, *pcur_sta = NULL;
-	struct	sta_priv *pstapriv = &adapter->stapriv;
+	struct sta_priv *pstapriv = &adapter->stapriv;
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
-	struct wlan_network	*pnetwork	= (struct wlan_network *)pbuf;
+	struct wlan_network *pnetwork = (struct wlan_network *)pbuf;
 	struct wlan_network *cur_network = &pmlmepriv->cur_network;
-	struct wlan_network	*pcur_wlan = NULL, *ptarget_wlan = NULL;
-	unsigned int		the_same_macaddr = false;
+	struct wlan_network *pcur_wlan = NULL, *ptarget_wlan = NULL;
+	unsigned int the_same_macaddr = false;
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("joinbss event call back received with res=%d\n", pnetwork->join_res));
 
@@ -1087,7 +1087,7 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 
 void rtw_joinbss_event_callback(struct adapter *adapter, u8 *pbuf)
 {
-	struct wlan_network	*pnetwork	= (struct wlan_network *)pbuf;
+	struct wlan_network *pnetwork = (struct wlan_network *)pbuf;
 
 	mlmeext_joinbss_event_callback(adapter, pnetwork->join_res);
 
@@ -1142,9 +1142,9 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 {
 	struct sta_info *psta;
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
-	struct stassoc_event	*pstassoc = (struct stassoc_event *)pbuf;
+	struct stassoc_event *pstassoc = (struct stassoc_event *)pbuf;
 	struct wlan_network *cur_network = &pmlmepriv->cur_network;
-	struct wlan_network	*ptarget_wlan = NULL;
+	struct wlan_network *ptarget_wlan = NULL;
 
 	if (!rtw_access_ctrl(adapter, pstassoc->macaddr))
 		return;
@@ -1209,8 +1209,8 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 	struct wlan_bssid_ex *pdev_network = NULL;
 	u8 *pibss = NULL;
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
-	struct	stadel_event *pstadel = (struct stadel_event *)pbuf;
-	struct	sta_priv *pstapriv = &adapter->stapriv;
+	struct stadel_event *pstadel = (struct stadel_event *)pbuf;
+	struct sta_priv *pstapriv = &adapter->stapriv;
 	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 
 	psta = rtw_get_stainfo(&adapter->stapriv, pstadel->macaddr);
@@ -1309,9 +1309,8 @@ void rtw_cpwm_event_callback(struct adapter *padapter, u8 *pbuf)
  */
 void _rtw_join_timeout_handler (struct timer_list *t)
 {
-	struct adapter *adapter =
-		from_timer(adapter, t, mlmepriv.assoc_timer);
-	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
+	struct adapter *adapter = from_timer(adapter, t, mlmepriv.assoc_timer);
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	int do_join_r;
 
 	DBG_88E("%s, fw_state=%x\n", __func__, get_fwstate(pmlmepriv));
@@ -1351,9 +1350,9 @@ void _rtw_join_timeout_handler (struct timer_list *t)
  */
 void rtw_scan_timeout_handler (struct timer_list *t)
 {
-	struct adapter *adapter =
-		from_timer(adapter, t, mlmepriv.scan_to_timer);
-	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
+	struct adapter *adapter = from_timer(adapter, t,
+					     mlmepriv.scan_to_timer);
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
 	DBG_88E(FUNC_ADPT_FMT" fw_state=%x\n", FUNC_ADPT_ARG(adapter), get_fwstate(pmlmepriv));
 	spin_lock_bh(&pmlmepriv->lock);
@@ -1379,8 +1378,8 @@ static void rtw_auto_scan_handler(struct adapter *padapter)
 
 void rtw_dynamic_check_timer_handlder(struct timer_list *t)
 {
-	struct adapter *adapter =
-		from_timer(adapter, t, mlmepriv.dynamic_chk_timer);
+	struct adapter *adapter = from_timer(adapter, t,
+					     mlmepriv.dynamic_chk_timer);
 	struct registry_priv *pregistrypriv = &adapter->registrypriv;
 
 	if (!adapter)
@@ -1414,7 +1413,8 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
 {
 	int updated = false;
 	unsigned long since_scan;
-	struct adapter *adapter = container_of(pmlmepriv, struct adapter, mlmepriv);
+	struct adapter *adapter = container_of(pmlmepriv, struct adapter,
+					       mlmepriv);
 
 	/* check bssid, if needed */
 	if (pmlmepriv->assoc_by_bssid) {
@@ -1470,9 +1470,9 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	struct list_head *phead;
 	struct adapter *adapter;
 	struct __queue *queue = &pmlmepriv->scanned_queue;
-	struct	wlan_network	*pnetwork = NULL;
-	struct	wlan_network	*candidate = NULL;
-	u8	supp_ant_div = false;
+	struct wlan_network *pnetwork = NULL;
+	struct wlan_network *candidate = NULL;
+	u8 supp_ant_div = false;
 
 	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 	phead = get_list_head(queue);
@@ -1527,10 +1527,10 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 
 int rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv)
 {
-	struct	cmd_obj *pcmd;
-	struct	setauth_parm *psetauthparm;
+	struct cmd_obj *pcmd;
+	struct setauth_parm *psetauthparm;
 	struct cmd_priv *pcmdpriv = &adapter->cmdpriv;
-	int		res = _SUCCESS;
+	int res = _SUCCESS;
 
 	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
 	if (!pcmd) {
@@ -1561,12 +1561,12 @@ int rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv)
 
 int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, int keyid, u8 set_tx)
 {
-	u8	keylen;
-	struct cmd_obj		*pcmd;
-	struct setkey_parm	*psetkeyparm;
+	u8 keylen;
+	struct cmd_obj *pcmd;
+	struct setkey_parm *psetkeyparm;
 	struct cmd_priv *pcmdpriv = &adapter->cmdpriv;
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
-	int	res = _SUCCESS;
+	int res = _SUCCESS;
 
 	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
 	if (!pcmd)
@@ -1646,7 +1646,7 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 /* adjust ies for rtw_joinbss_cmd in WMM */
 int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_len, uint initial_out_len)
 {
-	unsigned	int ielength = 0;
+	unsigned int ielength = 0;
 	unsigned int i, j;
 
 	/* i = 12; after the fixed IE */
@@ -1725,12 +1725,11 @@ static int rtw_append_pmkid(struct adapter *Adapter, int iEntry, u8 *ie, uint ie
 int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_len)
 {
 	u8 authmode;
-	uint	ielength;
+	uint ielength;
 	int iEntry;
-
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	struct security_priv *psecuritypriv = &adapter->securitypriv;
-	uint	ndisauthmode = psecuritypriv->ndisauthtype;
+	uint ndisauthmode = psecuritypriv->ndisauthtype;
 	uint ndissecuritytype = psecuritypriv->ndisencryptstatus;
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_,
@@ -1772,7 +1771,7 @@ void rtw_init_registrypriv_dev_network(struct adapter *adapter)
 {
 	struct registry_priv *pregistrypriv = &adapter->registrypriv;
 	struct eeprom_priv *peepriv = &adapter->eeprompriv;
-	struct wlan_bssid_ex    *pdev_network = &pregistrypriv->dev_network;
+	struct wlan_bssid_ex *pdev_network = &pregistrypriv->dev_network;
 	u8 *myhwaddr = myid(peepriv);
 
 	memcpy(pdev_network->MacAddress, myhwaddr, ETH_ALEN);
@@ -1791,9 +1790,9 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 {
 	int sz = 0;
 	struct registry_priv *pregistrypriv = &adapter->registrypriv;
-	struct wlan_bssid_ex    *pdev_network = &pregistrypriv->dev_network;
-	struct	security_priv *psecuritypriv = &adapter->securitypriv;
-	struct	wlan_network	*cur_network = &adapter->mlmepriv.cur_network;
+	struct wlan_bssid_ex *pdev_network = &pregistrypriv->dev_network;
+	struct security_priv *psecuritypriv = &adapter->securitypriv;
+	struct wlan_network *cur_network = &adapter->mlmepriv.cur_network;
 
 	pdev_network->Privacy = psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0; /*  adhoc no 802.1x */
 
@@ -1843,9 +1842,9 @@ void rtw_get_encrypt_decrypt_from_registrypriv(struct adapter *adapter)
 /* the function is at passive_level */
 void rtw_joinbss_reset(struct adapter *padapter)
 {
-	u8	threshold;
-	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv		*phtpriv = &pmlmepriv->htpriv;
+	u8 threshold;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 
 	/* todo: if you want to do something io/reg/hw setting before join_bss, please add code here */
 	pmlmepriv->num_FortyMHzIntolerant = 0;
@@ -1875,9 +1874,9 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 	enum ht_cap_ampdu_factor max_rx_ampdu_factor;
 	unsigned char *p;
 	unsigned char WMM_IE[] = {0x00, 0x50, 0xf2, 0x02, 0x00, 0x01, 0x00};
-	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
-	struct qos_priv		*pqospriv = &pmlmepriv->qospriv;
-	struct ht_priv		*phtpriv = &pmlmepriv->htpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct qos_priv *pqospriv = &pmlmepriv->qospriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	u32 rx_packet_offset, max_recvbuf_sz;
 
 	phtpriv->ht_option = false;
@@ -1939,10 +1938,10 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 /* the function is > passive_level (in critical_section) */
 void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len)
 {
-	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv		*phtpriv = &pmlmepriv->htpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
-	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (!phtpriv->ht_option)
@@ -2001,7 +2000,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 	u8 issued;
 	int priority;
 	struct sta_info *psta = NULL;
-	struct ht_priv	*phtpriv;
+	struct ht_priv *phtpriv;
 	struct pkt_attrib *pattrib = &pxmitframe->attrib;
 
 	if (is_multicast_ether_addr(pattrib->ra) ||
@@ -2034,7 +2033,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 
 void rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 {
-	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	spin_lock_bh(&pmlmepriv->lock);
 	_rtw_roaming(padapter, tgt_network);
@@ -2043,9 +2042,8 @@ void rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 
 void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 {
-	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	int do_join_r;
-
 	struct wlan_network *pnetwork;
 
 	if (tgt_network)
-- 
2.19.2


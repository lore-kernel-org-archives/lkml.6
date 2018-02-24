Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeBXVtL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 16:49:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751540AbeBXVtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 16:49:08 -0500
From: John Pittman <jpittman@redhat.com>
To: martin.petersen@oracle.com
Cc: jejb@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        John Pittman <jpittman@redhat.com>
Subject: [PATCH] scsi: qla2xxx: Fix braces styling issue
Date: Sat, 24 Feb 2018 16:49:04 -0500
Message-Id: <1519508944-7626-1-git-send-email-jpittman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In several spots throughout qla2xxx, checkpatch.pl has detected
braces being used to contain single statements.  Remove braces to
maintain consistency with the guidelines presented in section 3 of
coding-style.rst.

Signed-off-by: John Pittman <jpittman@redhat.com>
---
 drivers/scsi/qla2xxx/qla_init.c   | 21 +++++++--------------
 drivers/scsi/qla2xxx/qla_mbx.c    | 12 ++++--------
 drivers/scsi/qla2xxx/qla_mr.c     |  3 +--
 drivers/scsi/qla2xxx/qla_os.c     | 12 ++++--------
 drivers/scsi/qla2xxx/qla_target.c |  3 +--
 drivers/scsi/qla2xxx/qla_tmpl.c   | 12 ++++--------
 6 files changed, 21 insertions(+), 42 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 2dea112..25a314f 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -3046,9 +3046,8 @@ qla81xx_mpi_sync(scsi_qla_host_t *vha)
 	dw &= ~MPS_MASK;
 	dw |= dc;
 	rval = qla2x00_write_ram_word(vha, 0x7a15, dw);
-	if (rval != QLA_SUCCESS) {
+	if (rval != QLA_SUCCESS)
 		ql_log(ql_log_warn, vha, 0x0114, "Unable to gain sync.\n");
-	}
 
 done_release:
 	rval = qla2x00_write_ram_word(vha, 0x7c00, 0);
@@ -3824,9 +3823,8 @@ qla2x00_fw_ready(scsi_qla_host_t *vha)
 	 * Firmware should take at most one RATOV to login, plus 5 seconds for
 	 * our own processing.
 	 */
-	if ((wait_time = (ha->retry_count*ha->login_timeout) + 5) < min_wait) {
+	if ((wait_time = (ha->retry_count*ha->login_timeout) + 5) < min_wait)
 		wait_time = min_wait;
-	}
 
 	/* Min wait time if loop down */
 	mtime = jiffies + (min_wait * HZ);
@@ -3843,9 +3841,8 @@ qla2x00_fw_ready(scsi_qla_host_t *vha)
 		memset(state, -1, sizeof(state));
 		rval = qla2x00_get_firmware_state(vha, state);
 		if (rval == QLA_SUCCESS) {
-			if (state[0] < FSTATE_LOSS_OF_SYNC) {
+			if (state[0] < FSTATE_LOSS_OF_SYNC)
 				vha->device_flags &= ~DFLG_NO_CABLE;
-			}
 			if (IS_QLA84XX(ha) && state[0] != FSTATE_READY) {
 				ql_dbg(ql_dbg_taskm, vha, 0x801f,
 				    "fw_state=%x 84xx=%x.\n", state[0],
@@ -4665,9 +4662,8 @@ qla2x00_configure_loop(scsi_qla_host_t *vha)
 	if (test_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags)) {
 		if (test_bit(LOCAL_LOOP_UPDATE, &save_flags))
 			set_bit(LOCAL_LOOP_UPDATE, &vha->dpc_flags);
-		if (test_bit(RSCN_UPDATE, &save_flags)) {
+		if (test_bit(RSCN_UPDATE, &save_flags))
 			set_bit(RSCN_UPDATE, &vha->dpc_flags);
-		}
 	}
 
 	return (rval);
@@ -5379,9 +5375,8 @@ qla2x00_find_all_fabric_devs(scsi_qla_host_t *vha)
 					    new_fcport->port_name);
 				}
 
-				if (swl[swl_idx].d_id.b.rsvd_1 != 0) {
+				if (swl[swl_idx].d_id.b.rsvd_1 != 0)
 					last_dev = 1;
-				}
 				swl_idx++;
 			}
 		} else {
@@ -5647,9 +5642,8 @@ qla2x00_fabric_login(scsi_qla_host_t *vha, fc_port_t *fcport,
 		rval = ha->isp_ops->fabric_login(vha, fcport->loop_id,
 		    fcport->d_id.b.domain, fcport->d_id.b.area,
 		    fcport->d_id.b.al_pa, mb, BIT_0);
-		if (rval != QLA_SUCCESS) {
+		if (rval != QLA_SUCCESS)
 			return rval;
-		}
 		if (mb[0] == MBS_PORT_ID_USED) {
 			/*
 			 * Device has another loop ID.  The firmware team
@@ -5687,9 +5681,8 @@ qla2x00_fabric_login(scsi_qla_host_t *vha, fc_port_t *fcport,
 				fcport->port_type = FCT_INITIATOR;
 			} else {
 				fcport->port_type = FCT_TARGET;
-				if (mb[1] & BIT_1) {
+				if (mb[1] & BIT_1)
 					fcport->flags |= FCF_FCP2_DEVICE;
-				}
 			}
 
 			if (mb[10] & BIT_0)
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 7397aed..3bd00d6 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -1498,9 +1498,8 @@ qla2x00_lun_reset(struct fc_port *fcport, uint64_t l, int tag)
 	mcp->tov = MBX_TOV_SECONDS;
 	mcp->flags = 0;
 	rval = qla2x00_mailbox_command(vha, mcp);
-	if (rval != QLA_SUCCESS) {
+	if (rval != QLA_SUCCESS)
 		ql_dbg(ql_dbg_mbx, vha, 0x1043, "Failed=%x.\n", rval);
-	}
 
 	/* Issue marker IOCB. */
 	rval2 = qla2x00_marker(vha, req, rsp, fcport->loop_id, l,
@@ -4026,9 +4025,8 @@ qla2x00_send_change_request(scsi_qla_host_t *vha, uint16_t format,
 	rval = qla2x00_mailbox_command(vha, mcp);
 
 	if (rval == QLA_SUCCESS) {
-		if (mcp->mb[0] != MBS_COMMAND_COMPLETE) {
+		if (mcp->mb[0] != MBS_COMMAND_COMPLETE)
 			rval = BIT_1;
-		}
 	} else
 		rval = BIT_1;
 
@@ -4107,9 +4105,8 @@ qla84xx_verify_chip(struct scsi_qla_host *vha, uint16_t *status)
 	    "Entered %s.\n", __func__);
 
 	mn = dma_pool_alloc(ha->s_dma_pool, GFP_KERNEL, &mn_dma);
-	if (mn == NULL) {
+	if (mn == NULL)
 		return QLA_MEMORY_ALLOC_FAILED;
-	}
 
 	/* Force Update? */
 	options = ha->cs84xx->fw_update ? VCO_FORCE_UPDATE : 0;
@@ -4960,9 +4957,8 @@ qla2x00_echo_test(scsi_qla_host_t *vha, struct msg_echo_lb *mreq,
 	mcp->mb[0] = MBC_DIAGNOSTIC_ECHO;
 	/* BIT_6 specifies 64bit address */
 	mcp->mb[1] = mreq->options | BIT_15 | BIT_6;
-	if (IS_CNA_CAPABLE(ha)) {
+	if (IS_CNA_CAPABLE(ha))
 		mcp->mb[2] = vha->fcoe_fcf_idx;
-	}
 	mcp->mb[16] = LSW(mreq->rcv_dma);
 	mcp->mb[17] = MSW(mreq->rcv_dma);
 	mcp->mb[6] = LSW(MSD(mreq->rcv_dma));
diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index d5da398..2f84462 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -3298,9 +3298,8 @@ qlafx00_fxdisc_iocb(srb_t *sp, struct fxdisc_entry_fx00 *pfxiocb)
 			    cpu_to_le32(fxio->u.fxiocb.rsp_len);
 		}
 
-		if (fxio->u.fxiocb.flags & SRB_FXDISC_REQ_DWRD_VALID) {
+		if (fxio->u.fxiocb.flags & SRB_FXDISC_REQ_DWRD_VALID)
 			fx_iocb.dataword = fxio->u.fxiocb.req_data;
-		}
 		fx_iocb.flags = fxio->u.fxiocb.flags;
 	} else {
 		struct scatterlist *sg;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index afcb5567..3fadd0e 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1078,9 +1078,8 @@ qla2x00_eh_wait_on_command(struct scsi_cmnd *cmd)
 		return ret;
 	}
 
-	while (CMD_SP(cmd) && wait_iter--) {
+	while (CMD_SP(cmd) && wait_iter--)
 		msleep(ABORT_POLLING_PERIOD);
-	}
 	if (CMD_SP(cmd))
 		ret = QLA_FUNCTION_FAILED;
 
@@ -1409,9 +1408,8 @@ __qla2xxx_eh_generic_reset(char *name, enum nexus_wait_type type,
 	fc_port_t *fcport = (struct fc_port *) cmd->device->hostdata;
 	int err;
 
-	if (!fcport) {
+	if (!fcport)
 		return FAILED;
-	}
 
 	err = fc_block_scsi_eh(cmd);
 	if (err != 0)
@@ -1522,9 +1520,8 @@ qla2xxx_eh_bus_reset(struct scsi_cmnd *cmd)
 	id = cmd->device->id;
 	lun = cmd->device->lun;
 
-	if (!fcport) {
+	if (!fcport)
 		return ret;
-	}
 
 	ret = fc_block_scsi_eh(cmd);
 	if (ret != 0)
@@ -1667,9 +1664,8 @@ qla2x00_loop_reset(scsi_qla_host_t *vha)
 	struct fc_port *fcport;
 	struct qla_hw_data *ha = vha->hw;
 
-	if (IS_QLAFX00(ha)) {
+	if (IS_QLAFX00(ha))
 		return qlafx00_loop_reset(vha);
-	}
 
 	if (ql2xtargetreset == 1 && ha->flags.enable_target_reset) {
 		list_for_each_entry(fcport, &vha->vp_fcports, list) {
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 896b2d8..2f1507c 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -3112,9 +3112,8 @@ int qlt_xmit_response(struct qla_tgt_cmd *cmd, int xmit_type,
 
 	res = qlt_pre_xmit_response(cmd, &prm, xmit_type, scsi_status,
 	    &full_req_cnt);
-	if (unlikely(res != 0)) {
+	if (unlikely(res != 0))
 		return res;
-	}
 
 	spin_lock_irqsave(qpair->qp_lock_ptr, flags);
 
diff --git a/drivers/scsi/qla2xxx/qla_tmpl.c b/drivers/scsi/qla2xxx/qla_tmpl.c
index 731ca0d..d3d089f 100644
--- a/drivers/scsi/qla2xxx/qla_tmpl.c
+++ b/drivers/scsi/qla2xxx/qla_tmpl.c
@@ -141,9 +141,8 @@ qla27xx_read8(void __iomem *window, void *buf, ulong *len)
 {
 	uint8_t value = ~0;
 
-	if (buf) {
+	if (buf)
 		value = RD_REG_BYTE(window);
-	}
 	qla27xx_insert32(value, buf, len);
 }
 
@@ -152,9 +151,8 @@ qla27xx_read16(void __iomem *window, void *buf, ulong *len)
 {
 	uint16_t value = ~0;
 
-	if (buf) {
+	if (buf)
 		value = RD_REG_WORD(window);
-	}
 	qla27xx_insert32(value, buf, len);
 }
 
@@ -163,9 +161,8 @@ qla27xx_read32(void __iomem *window, void *buf, ulong *len)
 {
 	uint32_t value = ~0;
 
-	if (buf) {
+	if (buf)
 		value = RD_REG_DWORD(window);
-	}
 	qla27xx_insert32(value, buf, len);
 }
 
@@ -192,9 +189,8 @@ qla27xx_write_reg(__iomem struct device_reg_24xx *reg,
 {
 	__iomem void *window = (void __iomem *)reg + offset;
 
-	if (buf) {
+	if (buf)
 		WRT_REG_DWORD(window, data);
-	}
 }
 
 static inline void
-- 
2.7.5
